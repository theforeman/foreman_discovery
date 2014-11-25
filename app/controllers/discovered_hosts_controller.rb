class DiscoveredHostsController < ::ApplicationController
  include Foreman::Controller::AutoCompleteSearch
  include Foreman::Controller::TaxonomyMultiple
  unloadable

  # Avoid auth for discovered host creation
  skip_before_filter :require_login, :require_ssl, :authorize, :verify_authenticity_token, :set_taxonomy, :session_expiry, :update_activity_time, :only => :create

  before_filter :find_by_name, :only => %w[show edit update destroy refresh_facts convert]
  before_filter :find_multiple, :only => [:multiple_destroy, :submit_multiple_destroy]
  before_filter :taxonomy_scope, :only => [:edit]

  helper :hosts

  layout 'layouts/application'

  def index
    search = resource_base.search_for(params[:search], :order => params[:order])
    respond_to do |format|
      format.html do
        @hosts = search.includes(:location, :organization, :subnet, :model).paginate(:page => params[:page])
      end
      format.json { render :json => search }
    end
  end

  # Importing yaml is restricted to puppetmasters, so instead we take the ip
  # as a parameter and use refresh_facts to get the rest
  def create
    Taxonomy.no_taxonomy_scope do
      host, imported = Host::Discovered.new(:ip => get_ip_from_env).refresh_facts
      respond_to do |format|
        format.yml {
          if imported
            render :text => _("Imported discovered host"), :status => 200 and return
          else
            render :text => _("Failed to import facts for discovered host"), :status => 400
          end
        }
      end
    end
  rescue Exception => e
    logger.warn "Failed to import facts for discovered host: #{e}"
    render :text => _("Failed to import facts for discovered host: %s") % (e), :status => 400
  end

  def show
    # filter graph time range
    @range = nil

    # summary report text
    @report_summary = nil
  end

  def destroy
    @host.destroy
    redirect_to :action => 'index'
  end

  def edit
    @host         = @host.becomes(::Host::Managed)
    @host.type    = 'Host::Managed'
    @host.managed = true
    @host.build   = true

    render :template => 'hosts/edit'
  end

  def update
    @host         = @host.becomes(::Host::Managed)
    @host.type    = 'Host::Managed'
    forward_url_options
    Taxonomy.no_taxonomy_scope do
      if @host.update_attributes(params[:host])
        process_success :success_redirect => host_path(@host), :redirect_xhr => request.xhr?
      else
        taxonomy_scope
        load_vars_for_ajax
        offer_to_overwrite_conflicts
        process_error :object => @host, :render => 'hosts/edit'
      end
    end
  end

  def refresh_facts
    if @host.is_a?(::Host::Discovered) and @host.refresh_facts
      process_success :success_msg => _("Facts refreshed for %s") % @host.name, :success_redirect => :back
    else
      process_error :error_msg => _("Failed to refresh facts for %s") % @host.name, :redirect => :back
    end
  end

  def multiple_destroy
  end

  def submit_multiple_destroy
    # keep all the ones that were not deleted for notification.
    @hosts.delete_if {|host| host.destroy}

    missed_hosts = @hosts.map(&:name).join('<br/>')
    if @hosts.empty?
      notice _("Destroyed selected hosts")
    else
      error _("The following hosts were not deleted: %s") % missed_hosts
    end
    redirect_to(discovered_hosts_path)
  end

  def auto_complete_search
    begin
      @items = Host::Discovered.complete_for(params[:search])
      @items = @items.map do |item|
        category = (['and','or','not','has'].include?(item.to_s.sub(/^.*\s+/,''))) ? 'Operators' : ''
        part = item.to_s.sub(/^.*\b(and|or)\b/i) {|match| match.sub(/^.*\s+/,'')}
        completed = item.to_s.chomp(part)
        {:completed => completed, :part => part, :label => item, :category => category}
      end
    rescue ScopedSearch::QueryNotSupported => e
      @items = [{:error =>e.to_s}]
    end
    render :json => @items
  end

  private

  def resource_base
    @resource_base ||= ::Host::Discovered.authorized(current_permission, ::Host::Discovered)
  end

  def load_vars_for_ajax
    return unless @host

    @environment     = @host.environment
    @architecture    = @host.architecture
    @domain          = @host.domain
    @operatingsystem = @host.operatingsystem
    @medium          = @host.medium
  end

  # this is required for template generation (such as pxelinux) which is not done via a web request
  def forward_url_options(host = @host)
    host.url_options = url_options if @host.respond_to?(:url_options)
  end

  # if a save failed and the only reason was network conflicts then flag this so that the view
  # is rendered differently and the next save operation will be forced
  def offer_to_overwrite_conflicts
    @host.overwrite = "true" if @host.errors.any? and @host.errors.are_all_conflicts?
  end

  def controller_permission
    'discovered_hosts'
  end

  def action_permission
    case params[:action]
      when 'refresh_facts'
        :view
      when 'new', 'create'
        :provision
      when 'update_multiple_location', 'select_multiple_organization', 'update_multiple_organization', 'select_multiple_location'
        :edit
      when 'submit_multiple_destroy', 'multiple_destroy'
        :destroy
      else
        super
    end
  end

  def find_by_name
    params[:id].downcase! if params[:id].present?
    @host = resource_base.find_by_id(params[:id])
    @host ||= resource_base.find_by_name(params[:id])
    return false unless @host
  end

  def find_multiple
    # Lets search by name or id and make sure one of them exists first
    if params[:host_names].present? or params[:host_ids].present?
      @hosts = Host::Discovered.where("id IN (?) or name IN (?)", params[:host_ids], params[:host_names] )
      if @hosts.empty?
        error _('No hosts were found with that id or name')
        redirect_to(discovered_hosts_path) and return false
      end
    else
      error _('No hosts selected')
      redirect_to(discovered_hosts_path) and return false
    end

    return @hosts
  rescue => e
    error _("Something went wrong while selecting hosts - %s") % e
    redirect_to discovered_hosts_path
  end

  def get_ip_from_env
    # try to find host based on our client ip address
    ip = request.env['REMOTE_ADDR']

    # check if someone is asking on behave of another system (load balance etc)
    ip = request.env['HTTP_X_FORWARDED_FOR'] if request.env['HTTP_X_FORWARDED_FOR'].present?

    # Check for explicit parameter override
    ip = params.delete('ip') if params.include?('ip')

    # in case we got back multiple ips (see #1619)
    ip = ip.split(',').first
  end

  def taxonomy_scope
    if @host
      @organization = @host.organization
      @location = @host.location
    end

    if SETTINGS[:organizations_enabled]
      @organization ||= Organization.current
      @organization ||= Organization.my_organizations.first
    end
    if SETTINGS[:locations_enabled]
      @location ||= Location.current
      @location ||= Location.my_locations.first
    end
  end

end
