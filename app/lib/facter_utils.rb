module FacterUtils
  class << self
    # booted interface fact name
    def bootif_name
      Setting[:discovery_fact] || 'discovery_bootif'
    end

    # booted interface fact is present
    def bootif_present(facts)
      ! bootif_mac(facts).nil?
    end

    # booted interface MAC address (nil when not present)
    def bootif_mac(facts)
      facts[bootif_name]
    end
  end
end
