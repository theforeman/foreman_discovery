module ForemanDiscovery
  class ImportHook
    attr_reader :host, :facts

    def initialize(host:, facts:)
      @host = host
      @facts = facts
    end

    delegate :logger, to: Rails
  end
end
