module ForemanDiscovery
  class Facts < ::ProxyAPI::Resource
    def initialize args
      @url  = args[:url] + "/facts"
      super args
    end

    def facts
      parse get
    end
  end
end
