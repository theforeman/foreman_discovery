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

  def self.unused_ip_for_subnet(subnet, mac, existing_ip)
    ipam = subnet.unused_ip(mac)
    raise(::Foreman::Exception.new(N_("IPAM must be configured for subnet '%s'"), subnet)) unless ipam.present?

    # None IPAM returns nil - in that case keep the current address
    suggested_ip = ipam.suggest_ip
    suggested_ip.nil? ? existing_ip : suggested_ip
  end

  def self.unused_ip_for_host(host, new_subnet = nil, new_subnet6 = nil)
    host.interfaces.each do |interface|
      next unless interface.managed?

      interface.subnet = new_subnet if new_subnet
      interface.subnet6 = new_subnet6 if new_subnet6
      interface.ip = unused_ip_for_subnet(interface.subnet, interface.mac, interface.ip) if interface.subnet
      interface.ip6 = unused_ip_for_subnet(interface.subnet6, interface.mac, interface.ip6) if interface.subnet6
      interface.save!
    end
  end

  def self.change_subnet_and_unused_ip(host, hostgroup)
    if host.subnet != hostgroup.subnet || host.subnet6 != hostgroup.subnet6
      Rails.logger.debug "Discovered host subnets #{[host.subnet, host.subnet6]} do not match hostgroup subnets #{[hostgroup.subnet, hostgroup.subnet6]}"
      unused_ip_for_host(host, host.hostgroup.subnet, host.hostgroup.subnet6)
    else
      Rails.logger.debug "Discovered host subnets #{[host.subnet, host.subnet6]} match hostgroup subnets"
    end
  end
end
