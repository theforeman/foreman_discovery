# Ensure that module is namespaced with plugin name
module ForemanDiscovery
  class DiscoveredController < ::ApplicationController

    unloadable

    before_filter :find_by_name, :only => %w[show edit destroy refresh_facts convert]

    helper :hosts

    layout 'layouts/application'

    def index (title = nil)
      begin
        search = Host::Discovered.search_for(params[:search],:order => params[:order])
      rescue => e
        error e.to_s
        search = Host::Discovered.search_for ''
      end
      respond_to do |format|
        format.html do
          @hosts = search.paginate :page => params[:page]
        end
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
      @host         = @host.becomes(Host::Managed)
      @host.type    = 'Host::Managed'
      @host.mac     = @host.name
      @host.managed = true
      @host.setBuild

      render :template => 'hosts/edit'
    end

    def refresh_facts
      if @host.is_a?(Host::Discovered) and @host.refresh_facts
        process_success :success_msg =>  "Facts refreshed for #{@host.name}", :success_redirect => :back
      else
        process_error :error_msg => "Failed to refresh facts for #{@host.name}", :redirect => :back
      end
    end

    def find_by_name
      params[:id].downcase! if params[:id].present?
      @host = Host::Discovered.find_by_id(params[:id])
      @host ||= Host::Discovered.find_by_name(params[:id])
      return false unless @host
    end

  end
end
