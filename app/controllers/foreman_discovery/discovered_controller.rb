# Ensure that module is namespaced with plugin name
module ForemanDiscovery
  class DiscoveredController < ::ApplicationController
    before_filter :find_by_name, :only => %w[show destroy]

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

    def find_by_name
      @host = Host::Discovered.find_by_id(params[:id])
      @host ||= Host::Discovered.find_by_name(params[:id])
    end

  end
end
