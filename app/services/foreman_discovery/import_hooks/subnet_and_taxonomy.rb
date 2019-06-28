# Sets subnet, location and organization of a host based on the discovery facts
module ForemanDiscovery
  module ImportHooks
    class SubnetAndTaxonomy < ImportHook
      def after_populate
        primary_ip = host.primary_interface.ip
        primary_ip6 = host.primary_interface.ip6

        unless primary_ip || primary_ip6
          logger.warn "Unable to assign subnet - reboot trigger may not be possible, primary interface is missing IP address"
          return
        end

        # set subnet
        set_subnets(primary_ip, primary_ip6)
        # set location and organization
        set_location
        set_organization
      end

      private

      def set_subnets(ip, ip6)
        host.primary_interface.subnet = ForemanDiscovery::SubnetSuggestion.for(ip: ip, kind: 'IPv4') if ip
        host.primary_interface.subnet6 = ForemanDiscovery::SubnetSuggestion.for(ip: ip6, kind: 'IPv6') if ip6
      end

      def set_location
        host.location = suggested_location
        logger.info "Assigned location: #{host.location}"
      end

      def suggested_location
        logger.warn("Do not use 'foreman_location' fact for discovery and use 'discovery_location' instead") if facts["foreman_location"]
        Location.find_by_title(facts["discovery_location"]) ||
          Location.find_by_title(Setting[:discovery_location]) ||
          host.subnet.try(:locations).try(:first) ||
          Location.first
      end

      def set_organization
        host.organization = suggested_organization
        logger.info "Assigned organization: #{host.organization}"
      end

      def suggested_organization
        logger.warn("Do not use 'foreman_organization' fact for discovery and use 'discovery_organization' instead") if facts["foreman_organization"]
        Organization.find_by_title(facts["discovery_organization"]) ||
          Organization.find_by_title(Setting[:discovery_organization]) ||
          host.subnet.try(:organizations).try(:first) ||
          Organization.first
      end
    end
  end
end
