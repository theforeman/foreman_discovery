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
        return unless SETTINGS[:locations_enabled]
        host.location = suggested_location
        logger.info "Assigned location: #{host.location}"
      end

      def suggested_location
        Location.find_by_title(facts["foreman_location"] || facts["discovery_location"]) ||
          Location.find_by_title(Setting[:discovery_location]) ||
          host.subnet.try(:locations).try(:first) ||
          Location.first
      end

      def set_organization
        return unless SETTINGS[:organizations_enabled]
        host.organization = suggested_organization
        logger.info "Assigned organization: #{host.organization}"
      end

      def suggested_organization
        Organization.find_by_title(facts["foreman_organization"] || facts["discovery_organization"]) ||
          Organization.find_by_title(Setting[:discovery_organization]) ||
          host.subnet.try(:organizations).try(:first) ||
          Organization.first
      end
    end
  end
end
