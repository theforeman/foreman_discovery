module ForemanDiscovery
  class LldpNeighbors
    def set(iface, neighbor)
      interfaces[iface] = neighbor
    end

    def get(iface)
      interfaces[iface]
    end

    def list_by_pvid
      list = {}
      interfaces.each do |name, neighbor|
        next unless neighbor.has_key? 'PVID'
        vlan = neighbor['PVID']
        list[vlan] = [] unless list.has_key? vlan
        list[vlan].push name
      end

      list.each { |_, interfaces| interfaces.sort!}
      list
    end

    def interfaces
      @interfaces ||= {}
    end

    def get_neighbors_by_interface(ifname)
      return nil unless interfaces.has_key? ifname

      interface = get(ifname)
      return nil unless interface.has_key? 'PVID'

      list = []
      interfaces.each do |name, neighbor|
        next unless neighbor.has_key? 'PVID'
        list.push name if neighbor['PVID'] == interface['PVID']
      end

      return if list.size < 2
      list.sort
    end

    def self.eventually_make_bond(host)
      primary = host.primary_interface
      return if primary.nil?
      return if primary.type == 'Nic::Bond'

      neighbors = ::ForemanDiscovery::LldpNeighbors
                      .from_facts(host.facts_hash)
                      .get_neighbors_by_interface(primary.identifier)

      return if neighbors.nil?

      ip  = primary.ip
      mac = primary.mac
      name = primary.name
      primary.update(
          :primary   => false,
          :provision => false,
          :managed   => false,
          :name      => nil,
          :ip        => nil
      )

      bond = Nic::Bond.create(
          :identifier       => "bond0",
          :attached_devices => neighbors,
          :primary          => true,
          :provision        => true,
          :name             => name,
          :ip               => ip,
          :mac              => mac,
          :host             => host
      )

      bond.save!
      host.interfaces.push(bond)
    end

    def self.from_facts(facts)
      neighbors = self.new
      interfaces = {}
      facts.keys.each do |key|
        key_s = key.to_s
        next unless key_s.start_with? 'lldp_neighbor_'

        property, iface = key_s[14..-1].split('_', 2)
        if property == 'mngAddr'
          protocol, iface = iface.split('_', 2)
          property += '_' + protocol
        end
        interfaces[iface] = {} unless interfaces.has_key? iface
        interfaces[iface][property] = facts[key]
      end

      interfaces.each do |name, properties|
        neighbors.set name, properties
      end

      neighbors
    end
  end
end
