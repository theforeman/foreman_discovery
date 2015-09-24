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
    # set build only and only on final save (facts are deleted)
    if set_build
      # set legacy_api flag for post_queue actions
      host.legacy_api = self.legacy_host(host)
      # do not delete all facts (keep discovery ones)
      host.define_singleton_method(:clearFacts) do
        keep_ids = FactValue.where("host_id = #{host.id}").joins(:fact_name).where("fact_names.name like 'discovery_%'").pluck("fact_values.id")
        FactValue.where("host_id = #{host.id} and id not in (?)", keep_ids).delete_all
      end
      # set build flag (also deletes facts)
      host.build = set_build
    end
    host
  end

  def self.legacy_host(host)
    Gem::Version.new(host.facts['discovery_version'] || '1.0.0') < Gem::Version.new('3.0.0')
  end

end
