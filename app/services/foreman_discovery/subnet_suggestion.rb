module ForemanDiscovery
  class SubnetSuggestion
    attr_accessor :ip, :kind

    def self.for(ip:, kind:)
      new(ip: ip, kind: kind).()
    end

    def initialize(ip:, kind:)
      self.ip = ip
      self.kind = kind
    end

    def call
      return unless ip

      subnet = Subnet.unscoped.subnet_for(ip)
      if subnet
        Rails.logger.info "Detected #{kind} subnet: #{subnet} with taxonomy #{subnet.organizations.collect(&:name)}/#{subnet.locations.collect(&:name)}"
      else
        Rails.logger.info "#{kind} subnet could not be detected for #{ip}"
      end
      subnet
    end
  end
end
