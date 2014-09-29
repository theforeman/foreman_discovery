module PuppetFactParserExtensions
  extend ActiveSupport::Concern

  included do
    alias_method_chain :primary_interface, :discovery_fact
    alias_method_chain :ip, :discovery_fact
  end

  # we prefer discovery_bootif fact to choose right primary interface (interface used to boot the image)
  def primary_interface_with_discovery_fact
    mac = facts[discovery_mac_fact_name]
    interfaces.each do |int, values|
      return int.to_s if (values[:macaddress] == mac)
    end
    primary_interface_without_discovery_fact # fallback if we didn't find interface with such macaddress
  end

  # search for IP of interface with primary interface macaddress (ipaddress fact does not have to be interface used for boot)
  def ip_with_discovery_fact
    facts[:interfaces].split(',').each do |interface|
      if facts["macaddress_#{interface}"].try(:downcase) == facts[discovery_mac_fact_name].try(:downcase)
        return facts["ipaddress_#{interface}"]
      end
    end
    ip_without_discovery_fact # fallback if IP was not found
  end

  private

  def discovery_mac_fact_name
    Setting[:discovery_fact] || 'macaddress'
  end
end
