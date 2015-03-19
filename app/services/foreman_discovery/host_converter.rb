class ForemanDiscovery::HostConverter

  # must be called from SQL transaction
  def self.to_managed(original_host, set_managed = true, set_build = true)
    if ActiveRecord::Base.connection.open_transactions <= 0
      raise "This method must be executed with explicit transaction"
    end
    host = original_host.becomes(::Host::Managed)
    host.type = 'Host::Managed'
    # the following flags can be skipped when parameters are set to false
    if set_managed
      host.managed = set_managed
      host.primary_interface.managed = set_managed
    end
    host.build = set_build if set_build
    # this gets rolled back when anything in the transaction fails
    delete_discovery_attribute_set(host.id)
    host
  end

  private

  # discovery_attribute_set should be deleted only after a host has been successfully provisioned
  # (after discovered host becomes managed host)
  # after this happens the host is a manged host so non of the callbacks in discovered hosts are relevant anymore
  # for this reason the orphaned discovery_attribute_set needs to be searched for and deleted
  def self.delete_discovery_attribute_set(host_id)
    DiscoveryAttributeSet.destroy_all(:host_id => host_id)
  end
end
