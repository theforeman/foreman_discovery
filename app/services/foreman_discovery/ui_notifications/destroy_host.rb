module ForemanDiscovery
  module UINotifications
    # Remove discovery notifications when discovered hosts are removed or
    # provisioned.
    class DestroyHost < ::UINotifications::Base
      private

      def create
        # do nothing if we have other hosts
        return if other_discovered_hosts_available?

        # all discovered resources has been exusted, removing notifications
        blueprint.notifications.destroy_all
      end

      def other_discovered_hosts_available?
        Host::Discovered.where.not(id: subject.id).any?
      end

      def blueprint
        @blueprint ||= NotificationBlueprint.find_by(name: 'new_discovered_host')
      end
    end
  end
end
