# Ensure that module is namespaced with plugin name
module ForemanDiscovery
  class DiscoveredController < ::ApplicationController

    unloadable

    before_filter :find_by_name, :only => %w[show edit update destroy refresh_facts convert]

    helper :hosts

    layout 'layouts/application'

    def index
      begin
        @hosts = ::Host::Discovered.all.paginate :page => params[:page]
      end
    end

    def show
      respond_to do |format|
        format.html {
          # filter graph time range
          @range = nil

          # summary report text
          @report_summary = nil
        }
      end
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
          load_vars_for_ajax
          offer_to_overwrite_conflicts
          process_error
        end
      end
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

    def refresh_facts
      if @host.is_a?(::Host::Discovered) and @host.refresh_facts
        process_success :success_msg =>  "Facts refreshed for #{@host.name}", :success_redirect => :back
      else
        process_error :error_msg => "Failed to refresh facts for #{@host.name}", :redirect => :back
      end
    end

    def find_by_name
      params[:id].downcase! if params[:id].present?
      @host = ::Host::Discovered.find_by_id(params[:id])
      @host ||= ::Host::Discovered.find_by_name(params[:id])
      return false unless @host
    end

  end
end
