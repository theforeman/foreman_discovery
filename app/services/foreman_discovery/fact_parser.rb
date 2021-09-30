module ForemanDiscovery
  class FactParser < ::PuppetFactParser
    def suggested_primary_interface(host)
      raise(::Foreman::Exception.new(N_("Discovery fact parser does not work with non-discovery host '%{host}'") %
        {:host => host})) if host.type != "Host::Discovered"
      raise(::Foreman::Exception.new(N_("Discovered host '%{host}' has all NICs filtered out, filter: %{filter}") %
        {:host => host, :filter => Setting[:ignored_interface_identifiers]})) if interfaces.size == 0
      bootif_mac = FacterUtils::bootif_mac(facts).try(:downcase)
      detected = interfaces.detect { |_, values| values[:macaddress].try(:downcase) == bootif_mac && (values[:ipaddress].present? || values[:ipaddress6].present?) }
      Rails.logger.debug "Discovery fact parser detected primary interface: #{detected}"
      # return the detected interface as array [name, facts]
      detected || raise(::Foreman::Exception.new(N_("Unable to find primary NIC with %{mac} specified via '%{fact}', NIC filter: %{filter}") %
        {:mac => bootif_mac, :fact => FacterUtils::bootif_name, :filter => Setting[:ignored_interface_identifiers]}))
    end

    # ignores 'ignore_puppet_facts_for_provisioning' setting
    def parse_interfaces?
      true
    end

    # ignores 'update_subnets_from_facts' setting
    def get_facts_for_interface(interface)
      super.merge(keep_subnet: true)
    end

    def fact_name_class
      DiscoveryFactName
    end
  end
end
