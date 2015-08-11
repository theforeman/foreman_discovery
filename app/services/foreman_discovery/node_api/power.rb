module ForemanDiscovery::NodeAPI
  class Power
    class << self
      def service(data)
        PowerService.new(data)
      end

      def legacy_direct_service(data)
        PowerLegacyDirectService.new(data)
      end

      def legacy_proxied_service(data)
        PowerLegacyProxiedService.new(data)
      end
    end
  end

  class PowerService < NodeResource
    def url
      @args[:url] + "/power"
    end

    def reboot
      put({}, "/reboot")
    end

    def kexec(json)
      put(json, "/kexec")
    end

  end

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

  # legacy /reboot call via proxy
  class PowerLegacyProxiedService < NodeResource
    def initialize(args)
      super args.merge(:proxy => true)
    end

    def reboot
      put({}, "/reboot")
    end
  end
end
