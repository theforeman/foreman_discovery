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
end
