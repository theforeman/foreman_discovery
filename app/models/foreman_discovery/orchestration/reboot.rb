# Ensure that module is namespaced with plugin name
module ForemanDiscovery
  module Orchestration::Reboot
    def self.included(base)
      base.send :include, InstanceMethods
      base.class_eval do
        before_save :test_info
        after_save :queue_test
      end
    end

    module InstanceMethods

      protected

      def test_info
        @old_type = Host::Base.find(self).type
        logger.debug "ForemanDiscoveryOrchestration: before_save: old_type logged as #{@old_type}"
      end

      def queue_test
        logger.debug "ForemanDiscoveryOrchestration: after_save: old type retrieved as #{@old_type}"
        logger.debug "ForemanDiscoveryOrchestration: after_save: new logged as #{self.type}"
        if @old_type == "Host::Discovered" and self.type == "Host::Managed"
          logger.info "ForemanDiscoveryOrchestration: after_save: sending reboot to #{self.ip}"
          res = ::ProxyAPI::BMC.new(:url => "http://192.168.122.16:8443").power :action => "cycle"
          if res['result'] == true
            logger.info "ForemanDiscoveryOrchestration: after_save: reboot result: successful"
          else
            logger.info "ForemanDiscoveryOrchestration: after_save: reboot result: failed"
            logger.info res.inspect
            raise
          end
        else
          logger.debug "ForemanDiscoveryOrchestration: after_save: no action required"
        end
      end

    end
  end
end
