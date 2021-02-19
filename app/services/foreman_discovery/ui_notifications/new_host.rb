# frozen_string_literal: true
module ForemanDiscovery
  module UINotifications
    # Adds notification upon newly discovered Hosts
    # This class will only create one notification for newly discovered Hosts
    # and will update notification expiry when new discovered hosts appear.
    class NewHost < ::UINotifications::Base
      private

      def create
        add_notification
      end

      def update_notifications
        blueprint.mass_update_expiry
      end

      def add_notification
        Notification.create!(
          initiator: initiator,
          audience: ::Notification::AUDIENCE_SUBJECT,
          message: _("Host %s has been dicovered") % subject.name,
          subject: subject,
          notification_blueprint: blueprint
        )
      end

      def blueprint
        @blueprint ||= NotificationBlueprint.find_by(name: 'new_discovered_host')
      end
    end
  end
end
