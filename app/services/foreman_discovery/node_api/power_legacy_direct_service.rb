module ForemanDiscovery::NodeAPI
  # legacy /reboot call direct
  class PowerLegacyDirectService < NodeResource
    def initialize(args)
      super args
      raise ArgumentError, "Legacy direct service only supports http scheme" if scheme != 'http'
      raise ArgumentError, "Legacy direct service only supports port 8443" if port != 8443
      Foreman::Deprecation.deprecation_warning("1.11", "Discovery legacy API will be removed, use the new Power API")
    end

    def reboot
      ::ProxyAPI::BMC.new(:url => url).power :action => "cycle"
    end
  end
end
