module ForemanDiscovery::NodeAPI
  class Power
    class << self
      def service(data)
        ForemanDiscovery::NodeAPI::PowerService.new(data)
      end
    end
  end
end
