# Ensure that module is namespaced with plugin name
module ForemanDiscovery
  module Orchestration::Reboot
    def self.included(base)
      base.send :include, InstanceMethods
      base.class_eval do
        after_validation :queue_reboot
      end
    end

    module InstanceMethods

      protected

      def queue_reboot
        logger.debug type_changed?
        logger.debug old.inspect
        logger.debug old.type.inspect
        return
        return unless type_changed? and old.type == "Host::Discovered"
        post_queue.create(:name => "Rebooting #{self}", :priority => 10000,
                          :action => [self, :setReboot])
      end

      def setReboot
        logger.info "Rebooting #{name} as its being discovered and assigned"
        res = ::ProxyAPI::BMC.new(:url => "http://#{ip}:8443").power :action => "cycle"
        # res? we should abstract it in the BMC class
        if res['result'] == true
          logger.info "ForemanDiscoveryOrchestration: after_save: reboot result: successful"
        else
          failure "Failed to reboot: #{res.inpect}" # we don't get much back, but we may as well show itd
        end
      rescue => e
        failure "Failed to reboot: #{proxy_error e}"
      end

      def delReboot
        # nothing to do here, in reality we should never hit this method since this should be the
        # last action in the queue.
      end

    end
  end
end
