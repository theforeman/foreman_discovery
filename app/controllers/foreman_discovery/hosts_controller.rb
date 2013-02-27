# Ensure that module is namespaced with plugin name
module ForemanDiscovery

  # Example: Plugin's HostsController inherits from Foreman's HostsController
  class HostsController < ::HostsController

    # change layout if
    # layout 'foreman_discovery/layouts/new_layout'

    # separate display for discovered hosts
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

  end
end
