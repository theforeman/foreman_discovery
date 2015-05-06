module Host::ManagedExtensions
  extend ActiveSupport::Concern

  included do
    # execute standard callbacks
    after_validation :queue_reboot
    after_save :delete_discovery_attribute_set

    belongs_to :discovery_rule
  end

  def queue_reboot
    return if new_record? # Discovered Hosts already exist, and new_records will break `find`
    return unless type_changed? and ::Host::Base.find(self.id).type == "Host::Discovered"
    post_queue.create(:name => _("Rebooting %s") % self, :priority => 10000,
                      :action => [self, :setReboot])
  end

  def setReboot
    old.becomes(Host::Discovered).reboot
  end

  def delReboot
    # nothing to do here, in reality we should never hit this method since this should be the
    # last action in the queue.
  end

  def delete_discovery_attribute_set
    return if new_record?
    DiscoveryAttributeSet.destroy_all(:host_id => self.id) if type_changed?
  end

end
