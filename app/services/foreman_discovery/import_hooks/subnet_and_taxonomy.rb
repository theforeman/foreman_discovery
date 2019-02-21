# Sets subnet, location and organization of a host based on the discovery facts
module ForemanDiscovery
  module ImportHooks
    class SubnetAndTaxonomy < ImportHook
      def after_populate
        primary_ip = host.primary_interface.ip

        unless primary_ip
          logger.warn "Unable to assign subnet - reboot trigger may not be possible, primary interface is missing IP address"
          return
        end

        # set subnet
        set_subnet(primary_ip)
        # set location and organization
        set_location
        set_organization
      end

      private

      def set_subnet(ip)
        host.primary_interface.subnet = suggested_subnet(ip)
      end

      def suggested_subnet(ip)
        subnet = Subnet.subnet_for(ip)
        if subnet
          logger.info "Detected subnet: #{subnet} with taxonomy #{subnet.organizations.collect(&:name)}/#{subnet.locations.collect(&:name)}"
        else
          logger.warn "Subnet could not be detected for #{ip}"
        end
        subnet
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
