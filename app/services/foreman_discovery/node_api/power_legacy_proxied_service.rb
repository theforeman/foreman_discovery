module ForemanDiscovery::NodeAPI
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
