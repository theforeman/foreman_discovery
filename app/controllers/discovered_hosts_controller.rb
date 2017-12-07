class DiscoveredHostsController < ::ApplicationController
  include Foreman::Controller::Parameters::DiscoveredHost
  include Foreman::Controller::AutoCompleteSearch
  include Foreman::Controller::TaxonomyMultiple
  include Foreman::Controller::DiscoveredExtensions
  include ActionView::Helpers::NumberHelper

  before_action :find_by_name, :only => %w[edit update destroy refresh_facts convert reboot auto_provision]
  before_action :find_by_name_incl_subnet, :only => [:show]
  before_action :find_multiple, :only => [:multiple_destroy, :submit_multiple_destroy]
  before_action :taxonomy_scope, :only => [:edit]

  around_action :skip_bullet, :only => [:edit]

  helper :hosts

  layout 'layouts/application'

  def model_of_controller
    Host::Discovered
  end

  def index
    @hosts = resource_base.search_for(params[:search], :order => params[:order]).includes([
      :location,
      :organization,
      :model,
      :discovery_attribute_set
    ], {:interfaces => :subnet}).paginate(:page => params[:page])
    fact_array = @hosts.collect do |host|
      [host.id, Hash[host.fact_values.joins(:fact_name).where('fact_names.name' => Setting::Discovered.discovery_fact_column_array).pluck(:name, :value)]]
    end
    @host_facts = Hash[fact_array]
  end

  def show
    # filter graph time range
    @range = nil
    # summary report text
    @report_summary = nil
    init_regex_and_categories
    @interfaces = []
    get_interfaces
    @host.facts_hash.each do |key, value|
      value = number_to_human_size(value) if /size$/.match(key)
      assign_fact_to_category(key, value)
    end
    add_custom_facts
  end

  def destroy
    @host.destroy
    redirect_to :action => 'index'
  end

  def edit
    @host = ::ForemanDiscovery::HostConverter.to_managed(@host, true, false, discovered_host_params_host) unless @host.nil?
    setup_host_class_variables
    @override_taxonomy = true
    if params[:quick_submit]
      perform_update(@host, _('Successfully provisioned %s') % @host.name)
    else
      @host.build = true
      render :template => 'discovered_hosts/edit'
    end
  end

  def update
    @host = ::ForemanDiscovery::HostConverter.to_managed(@host, true, true, managed_host_params_host)
    forward_url_options

    perform_update(@host)
  end

  def perform_update(host, success_message = nil)
    Taxonomy.no_taxonomy_scope do
      ::ForemanDiscovery::HostConverter.set_build_clean_facts(host)
      if host.save
        success_options = { :success_redirect => host_path(host), :redirect_xhr => request.xhr? }
        success_options[:success_msg] = success_message if success_message
        process_success success_options
      else
        taxonomy_scope
        load_vars_for_ajax
        offer_to_overwrite_conflicts
        process_error :object => host, :render => 'discovered_hosts/edit'
      end
    end
  end

  def refresh_facts
    if @host.is_a?(::Host::Discovered) && @host.refresh_facts
      process_success :success_msg => _("Facts refreshed for %s") % @host.name, :success_redirect => :back
    else
      process_error :error_msg => _("Failed to refresh facts for %s") % @host.name, :redirect => :back
    end
  rescue => e
    exception = Foreman::WrappedException.new(e, N_("Failed to refresh facts for %{hostname} with error %{error_message}"), :hostname => @host.name, :error_message => e.message)
    Foreman::Logging.exception exception.message, e
    process_error :error_msg => exception.message, :redirect => :back
  end

  def reboot
    unless @host.is_a?(::Host::Discovered)
      process_error :error_msg => _("Host of type %s can not be rebooted") % @host.type, :redirect => :back
    end

    if @host.reboot
      process_success :success_msg => _("Rebooting host %s") % @host.name, :success_redirect => :back
    else
      process_error :error_msg => _("Failed to reboot host %s") % @host.name, :redirect => :back
    end
  rescue => e
    exception = Foreman::WrappedException.new(e, N_("Failed to reboot host %{hostname} with error %{error_message}"), :hostname => @host.name, :error_message => e.message)
    Foreman::Logging.exception exception.message, e
    process_error :error_msg => exception.message, :redirect => :back
  end

  def reboot_all
    error_message = perform_reboot_all

    if error_message
      process_error :error_msg => error_message, :redirect => :back
    else
      process_success :success_msg => _("Discovered hosts are rebooting now"), :success_redirect => :back
    end
  rescue => e
    exception = Foreman::WrappedException.new(e, N_("Failed to reboot hosts with error %s"), e.message)
    Foreman::Logging.exception exception.message, e
    process_error :error_msg => exception.message, :redirect => :back
  end

  def multiple_destroy
  end

  def submit_multiple_destroy
    # keep all the ones that were not deleted for notification.
    missed_hosts = @hosts.select {|host| !host.destroy }
    if missed_hosts
      notice _("Destroyed selected hosts")
    else
      error _("The following hosts were not deleted: %s") % missed_hosts
    end
    redirect_to(discovered_hosts_path)
  end

  def auto_provision
    if rule = find_discovery_rule(@host)
      if perform_auto_provision(@host, rule)
        process_success :success_msg => _("Host %{host} was provisioned with rule %{rule}") % {:host => @host.name, :rule => rule.name}, :success_redirect => discovered_hosts_path
      else
        errors = @host.errors.full_messages.join(' ')
        logger.warn "Failed to auto provision host %s: %s" % [@host.name, errors]
        process_error :error_msg => _("Failed to auto provision host %s: %s") % [@host.name, errors], :redirect => :back
      end
    else
      process_success :success_msg => _("No rule found for host %s") % @host.name, :success_redirect => :back
    end
  end

  def auto_provision_all
    result = true
    error_message = _("Errors during auto provisioning: %s")

    if Host::Discovered.count == 0
      error_message = _("No discovered hosts to provision")
      result = false
    end

    overall_errors = ""
    Host::Discovered.all.each do |discovered_host|
      if rule = find_discovery_rule(discovered_host)
        result &= perform_auto_provision(discovered_host, rule)
        unless discovered_host.errors.empty?
          errors = discovered_host.errors.full_messages.join(' ')
          logger.warn "Failed to auto provision host %s: %s" % [discovered_host.name, errors]
          overall_errors << "#{discovered_host.name}: #{errors} "
        end
      end
    end
    if result
      process_success :success_msg => _("Discovered hosts are provisioning now"), :success_redirect => :back
    else
      process_error :error_msg => error_message % overall_errors, :redirect => :back
    end
  end

  private

  def setup_host_class_variables
    if @host.hostgroup
      @architecture    = @host.hostgroup.architecture
      @operatingsystem = @host.hostgroup.operatingsystem
      @environment     = @host.hostgroup.environment
      @domain          = @host.hostgroup.domain
      @subnet          = @host.hostgroup.subnet
      @compute_profile = @host.hostgroup.compute_profile
      @realm           = @host.hostgroup.realm
      @host.interfaces.first.assign_attributes(subnet: @subnet,
                                               domain: @domain)
      @host.environment = @environment
    end
  end

  def init_regex_and_categories
    hightlights = Setting[:discovery_facts_highlights].empty? ? /^(productname|memorysize|manufacturer|architecture|macaddress$|processorcount|physicalprocessorcount|discovery_subnet|discovery_boot|ipaddress$)/ : Regexp.new(Setting[:discovery_facts_highlights])
    storage = Setting[:discovery_facts_storage].empty? ? /^blockdevice/ : Regexp.new(Setting[:discovery_facts_storage])
    hardware = Setting[:discovery_facts_hardware].empty? ? /^(hardw|manufacturer|memo|process)/ : Regexp.new(Setting[:discovery_facts__hardware])
    network = Setting[:discovery_facts_network].empty? ? /^(interfaces|dhcp|fqdn|hostname)/ : Regexp.new(Setting[:discovery_facts_network])
    software = Setting[:discovery_facts_software].empty? ? /^(bios|os|discovery)/ : Regexp.new(Setting[:discovery_facts_software])
    ipmi = Setting[:discovery_facts_ipmi].empty? ? /^ipmi/ : Regexp.new(Setting[:discovery_facts_ipmi])
    @regex_array = [hightlights, storage, hardware, network, software, ipmi, false]
    @categories = Array.new(7) { Hash.new }
    @categories_names = [N_("Highlights"), N_("Storage"), N_("Hardware"), N_("Network"), N_("Software"), N_("IPMI"), N_("Miscellaneous")]
  end

  def assign_fact_to_category(key, value)
    if @interfaces.any? {|interface| key.include? interface[:identifier]}
      @categories[3][key] = value
      return
    end
    @regex_array.each_with_index do |regex, index|
      if !regex
        @categories[index][key] = value
      elsif regex.match key
        @categories[index][key] = value
        break
      end
    end
  end

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
      when 'refresh_facts', 'reboot', 'reboot_all', 'update_multiple_location', 'select_multiple_organization', 'update_multiple_organization', 'select_multiple_location'
        :edit
      when 'submit_multiple_destroy', 'multiple_destroy'
        :destroy
      when 'auto_provision', 'auto_provision_all'
        :auto_provision
      else
        super
    end
  end

  def find_by_name(*includes)
    not_found and return false if (id = params[:id]).blank?
    id.downcase!
    @host = includes.empty? ? resource_base.find_by_id(id) : resource_base.includes(includes).find_by_id(id)
    @host ||= includes.empty? ? resource_base.find_by_name(id) : resource_base.includes(includes).find_by_name(id)
    not_found and return(false) unless @host
    @host
  end

  def find_by_name_incl_subnet
    find_by_name({:interfaces => :subnet})
  end

  def find_multiple
    # Lets search by name or id and make sure one of them exists first
    if params[:host_names].present? or params[:host_ids].present?
      @hosts = Host::Discovered.includes(:model, :fact_values, :interfaces, :location, :organization).where("id IN (?) or name IN (?)", params[:host_ids], params[:host_names] )
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

  # particular actions will always raise N+1 queries
  def skip_bullet
    Bullet.enable = false if defined? Bullet
    yield
  ensure
    Bullet.enable = true if defined? Bullet
  end

  def get_interfaces
    @host.interfaces.each do |interface|
      @interfaces << {:identifier => interface["identifier"], :type => interface["type"], :mac => interface["mac"], :ip => interface["ip"]? interface["ip"] : "N/A", :primary => interface["primary"], :provision => interface["provision"]}
    end
  end

  def add_custom_facts
    unless @host.primary_interface.subnet.nil?
      discovery_subnet = "#{@host.primary_interface.subnet.name} (#{@host.primary_interface.subnet.network})"
      assign_fact_to_category("discovery_subnet", discovery_subnet)
    end
  end
end
