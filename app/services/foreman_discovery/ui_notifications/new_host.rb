module ForemanDiscovery
  module UINotifications
    # Adds notification upon newly discovered Hosts
    # This class will only create one notification for newly discovered Hosts
    # and will update notification expiry when new discovered hosts appear.
    class NewHost < ::UINotifications::Base
      private

      def create
        User.as_anonymous_admin do
          blueprint.notifications.any? ? update_notifications : add_notification
        end
      end

      def update_notifications
        blueprint.mass_update_expiry
        blueprint.mass_set_seen(false)
      end

      def add_notification
        Notification.create!(
          initiator: initiator,
          audience: ::Notification::AUDIENCE_ADMIN,
          notification_blueprint: blueprint
        )
      end

      def blueprint
        @blueprint ||= NotificationBlueprint.find_by(name: 'new_discovered_host')
      end
    end
  end
end
