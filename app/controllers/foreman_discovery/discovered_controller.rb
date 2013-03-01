# Ensure that module is namespaced with plugin name
module ForemanDiscovery
  class DiscoveredController < ::ApplicationController

    unloadable

    before_filter :find_by_name, :only => %w[show destroy refresh_facts convert]
    before_filter :change_host_type, :only =>%w[edit update]

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
      redirect_to :action => "index"
    end

    def edit
      # This is really bad ...
      redirect_to edit_host_path(@host)
    end

    def refresh_facts
      if @host.is_a?(Host::Discovered) and @host.refresh_facts
        process_success :success_msg =>  "Facts refreshed for #{@host.name}", :success_redirect => :back
      else
        process_error :error_msg => "Failed to refresh facts for #{@host.name}", :redirect => :back
      end
    end

    def find_by_name
      @host = Host::Discovered.find_by_id(params[:id])
      @host ||= Host::Discovered.find_by_name(params[:id])
    end

    def change_host_type
      # We'll only ever edit a host when converting it to Managed, so change the type
      @host ||= Host::Discovered.find_by_name params[:id]
      type = Host::Managed
      Host.connection.execute "UPDATE 'hosts' SET type = '#{type}' WHERE id = '#{@host.id}'"
      @host = @host.becomes(type)
      @host.type = type.to_s
      @host.mac = @host.name
      @host.managed = true
      @host.setBuild
    end

  end
end
