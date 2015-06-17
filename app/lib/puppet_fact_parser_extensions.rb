module PuppetFactParserExtensions
  extend ActiveSupport::Concern

  included do
    begin
      raise "method: suggested_primary_interface" unless instance_methods.include?(:suggested_primary_interface)
      raise "method: parse_interfaces?" unless instance_methods.include?(:parse_interfaces?)
      alias_method_chain :suggested_primary_interface, :bootif
      alias_method_chain :parse_interfaces?, :bootif
    rescue Exception => e
      raise ::Foreman::WrappedException.new(e, N_("Incompatible version of puppet fact parser"))
    end
  end

  # discovery has its own method of finding primary iface
  def suggested_primary_interface_with_bootif(host)
    return suggested_primary_interface_without_bootif(host) if host.type != "Host::Discovered"
    bootif_mac = FacterUtils::bootif_mac(facts).try(:downcase)
    detected = interfaces.detect { |_, values| values[:macaddress].try(:downcase) == bootif_mac }
    Rails.logger.debug "Detected primary interface: #{detected}"
    # return the detected interface as array [name, facts]
    detected || raise(::Foreman::Exception.new(N_("Unable to detect primary interface using MAC '%{mac}' specified by discovery_fact '%{fact}'") % {:mac => bootif_mac, :fact => FacterUtils::bootif_name}))
  end

  # make 'ignore_puppet_facts_for_provisioning' setting non-effective
  def parse_interfaces_with_bootif?
    true
  end
end
