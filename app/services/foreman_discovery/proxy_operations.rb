module ForemanDiscovery
  class ProxyOperations < ::ProxyAPI::Resource
    def initialize args
      @url  = args[:url]
      @operation = args[:operation]
      super args
    end

    def parse_put_operation
      parse put({}, "/#{@operation}")
    end

    def parse_get_operation
      @url  += "/#{@operation}"
      parse get
    end
  end
end
