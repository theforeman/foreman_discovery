module ForemanDiscovery
  class ImportHookService
    HOOKS = [
      ForemanDiscovery::ImportHooks::DiscoveryAttribute,
      ForemanDiscovery::ImportHooks::LldpNeighbor,
      ForemanDiscovery::ImportHooks::SubnetAndTaxonomy,
      ForemanDiscovery::ImportHooks::LockTemplates
    ]

    attr_reader :host, :facts

    def initialize(host:, facts:)
      @host = host
      @facts = facts
    end

    def after_populate
      HOOKS.each do |hook_class|
        hook = hook_class.new(host: host, facts: facts)
        hook.after_populate
      end
    end
  end
end
