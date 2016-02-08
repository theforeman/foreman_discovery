module ForemanDiscovery
  class FactParser < ::PuppetFactParser
    def suggested_primary_interface(host)
      raise("Discovery fact parser does not work with non-discovery host #{host}") if host.type != "Host::Discovered"
      bootif_mac = FacterUtils::bootif_mac(facts).try(:downcase)
      detected = interfaces.detect { |_, values| values[:macaddress].try(:downcase) == bootif_mac }
      Rails.logger.debug "Discovery fact parser detected primary interface: #{detected}"
      # return the detected interface as array [name, facts]
      detected || raise(::Foreman::Exception.new(N_("Unable to detect primary interface using MAC '%{mac}' specified by discovery_fact '%{fact}'") % {:mac => bootif_mac, :fact => FacterUtils::bootif_name}))
    end

    def parse_interfaces?
      true # to make 'ignore_puppet_facts_for_provisioning' setting non-effective
    end
  end
end
