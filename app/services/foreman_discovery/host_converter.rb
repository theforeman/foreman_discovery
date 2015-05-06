class ForemanDiscovery::HostConverter

  # Converts discovered host to managed host without uptading the database.
  # Record must be saved explicitly (using save! or update_attributes! or similar).
  # This method MUST be called from a SQL transaction.
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
    host
  end

end
