# Automatically bonds interfaces based on lldp facts
module ForemanDiscovery
  module ImportHooks
    class LldpNeighbor < ImportHook
      def after_populate
        return unless Setting[:discovery_auto_bond]
        ::ForemanDiscovery::LldpNeighbors.eventually_make_bond(host)
      end
    end
  end
end
