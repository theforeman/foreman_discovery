module Host::ManagedExtensions
  extend ActiveSupport::Concern

  included do
    # execute standard callbacks
    after_validation :queue_reboot

    belongs_to :discovery_rule
  end

  def queue_reboot
    return if new_record? # Discovered Hosts already exist, and new_records will break `find`
    return unless type_changed? and ::Host::Base.find(self.id).type == "Host::Discovered"
    post_queue.create(:name => _("Rebooting %s") % self, :priority => 10000,
                      :action => [self, :setReboot])
  end

  def setReboot
    logger.info "ForemanDiscovery: Rebooting #{name} as its being discovered and assigned"
    if ::ProxyAPI::BMC.new(:url => "http://#{old.try(:ip) || ip}:8443").power :action => "cycle"
      logger.info "ForemanDiscovery: reboot result: successful"
    else
      logger.info "ForemanDiscovery: reboot result: failed"
    end
  rescue => e
    failure _("Failed to reboot: %s") % e.message
  end

  def delReboot
    # nothing to do here, in reality we should never hit this method since this should be the
    # last action in the queue.
  end

end
