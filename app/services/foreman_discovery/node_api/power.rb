module ForemanDiscovery::NodeAPI
  class Power
    class << self
      def service(data)
        ForemanDiscovery::NodeAPI::PowerService.new(data)
      end

      def legacy_direct_service(data)
        ForemanDiscovery::NodeAPI::PowerLegacyDirectService.new(data)
      end

      def legacy_proxied_service(data)
        ForemanDiscovery::NodeAPI::PowerLegacyProxiedService.new(data)
      end
    end
  end
end
