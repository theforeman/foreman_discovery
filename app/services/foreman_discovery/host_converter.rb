class ForemanDiscovery::HostConverter

  # Converts discovered host to managed host without uptading the database.
  # Record must be saved explicitly (using save! or update_attributes! or similar).
  # Creates shallow copy.
  def self.to_managed(original_host, set_managed = true, set_build = true, added_attributes = {})
    host = original_host.becomes(::Host::Managed)
    host.type = 'Host::Managed'
    host.attributes = host.apply_inherited_attributes(added_attributes)
    host.set_hostgroup_defaults if host.hostgroup_id.present?

    # the following flags can be skipped when parameters are set to false
    if set_managed
      host.managed = set_managed
      host.primary_interface.managed = set_managed
    end
    # set build only and only on final save (facts are deleted)
    set_build_clean_facts(host) if set_build
    host
  end

  def self.set_build_clean_facts(host)
    # fact cleaning
    if Setting['discovery_clean_facts']
      # clean all facts except those starting with "discovery_"
      host.define_singleton_method(:clear_facts) do
          keep_ids = FactValue.where("host_id = #{host.id}").joins(:fact_name).where("fact_names.name like 'discovery_%'").pluck("fact_values.id")
          FactValue.where("host_id = #{host.id} and id not in (?)", keep_ids).delete_all
      end
    else
      # clean no facts (default behavior)
      host.define_singleton_method(:clear_facts) {}
    end
    # set build flag
    host.build = true
  end

end
