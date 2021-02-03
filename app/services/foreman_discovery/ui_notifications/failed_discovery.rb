# frozen_string_literal: true
module ForemanDiscovery
  module UINotifications
    # Adds notification upon failed discovery
    class FailedDiscovery < ::UINotifications::Base
      def initialize(message)
        @message = message
      end

      private

      def create
        add_notification if update_notifications.zero?
      end

      def update_notifications
        blueprint.mass_update_expiry
      end

      def add_notification
        Notification.create!(
          initiator: initiator,
          audience: ::Notification::AUDIENCE_ADMIN,
          message: _("One or more hosts with failed discovery due to error: #{@message}"),
          notification_blueprint: blueprint,
        )
      end

      def blueprint
        @blueprint ||= NotificationBlueprint.find_by(name: 'failed_discovery')
      end
    end
  end
end
