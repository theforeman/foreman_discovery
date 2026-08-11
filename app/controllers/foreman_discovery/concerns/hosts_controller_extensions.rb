module ForemanDiscovery
  module Concerns
    module HostsControllerExtensions
      extend ActiveSupport::Concern
      prepended do
        before_action :set_discovered_params
      end

      # Change params to what the hosts controller expects. Certain methods
      # in the hosts controller like all the _selected methods, taxonomy_scope,
      # etc.. expect a params[:host] to work.
      def set_discovered_params
        return if params[:discovered_host].nil?
        params[:host] ||= params.delete(:discovered_host)
      end

      def host_for_template_used
        super

        @host = ::ForemanDiscovery::HostConverter.to_managed(@host, true, false, host_params) if @host.is_a?(Host::Discovered)
      end

      def find_resource
        if (id = params[:id]).blank?
          not_found
          return false
        end
        @host = Host::Discovered.authorized(:edit_discovered_hosts, Host::Discovered).find_by_id(id)
        @host ||= super
        @host
      end

    end
  end
end
