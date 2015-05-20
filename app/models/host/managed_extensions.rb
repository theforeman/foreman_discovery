module Host::ManagedExtensions
  extend ActiveSupport::Concern

  included do
    # execute standard callbacks
    after_validation :queue_reboot
    after_save :delete_discovery_attribute_set

    belongs_to :discovery_rule
  end

  def queue_reboot
    return unless errors.empty? && Setting[:discovery_reboot]
    return if new_record? # Discovered Hosts already exist, and new_records will break `find`
    return unless type_changed? and ::Host::Base.find(self.id).type == "Host::Discovered"
    # reboot task must be high priority and there is no compensation action apparently
    post_queue.create(:name => _("Rebooting %s") % self, :priority => 10000,
                      :action => [self, :setReboot])
  end

  def setReboot
    old.becomes(Host::Discovered).reboot
    # It is too late to report error in the post_queue, we catch them and
    # continue. If flash is implemented for new hosts (http://projects.theforeman.org/issues/10559)
    # we can report the error to the user perhaps.
    true
  rescue ::Foreman::Exception
    true
  end

  def delete_discovery_attribute_set
    return if new_record?
    DiscoveryAttributeSet.destroy_all(:host_id => self.id) if type_changed?
  end

end
