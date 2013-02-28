# Ensure that module is namespaced with plugin name
module ForemanDiscovery
  # Example: Create new instance and class methods on Foreman's Host model
  module HostsControllerExtensions
    extend ActiveSupport::Concern

    def discovered (title = nil)
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

    def disc_show
      @host = Host::Discovered.find(params[:id])
      respond_to do |format|
        format.html {
          # filter graph time range
          @range = nil

          # summary report text
          @report_summary = nil
        }
      end
    end

  end
end
