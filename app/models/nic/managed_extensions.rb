module Nic::ManagedExtensions
  extend ActiveSupport::Concern

  included do
    after_validation :discovery_queue_rebuild_dns
  end

  def discovery_queue_rebuild_dns
    return unless (dns? || dns6? || reverse_dns? || reverse_dns6?) && errors.empty? && Setting[:discovery_always_rebuild_dns]
    return if self.host.new_record? # Discovered Hosts already exist, and new_records will break `find`
    return unless self.host.type_changed? and ::Host::Base.find(self.host.id).type == "Host::Discovered"
    return if self.pending_dns_record_changes?
    logger.debug "Queuing DNS rebuild for #{self}"
    queue.create(:name => _("Rebuild DNS for %s") % self, :priority => 10, :action => [self, :set_discovery_rebuild_dns])
  end

  def set_discovery_rebuild_dns
    logger.debug "Executing DNS rebuild for #{self}"
    rebuild_dns
  end

  def del_discovery_rebuild_dns
    # Just a place holder, so if rollback is needed, we won't get an exception about not knowing how to rollback.
    # This is a no-op, since we cannot really rollback rebuild_dns
  end
end
