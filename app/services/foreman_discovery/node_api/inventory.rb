module ForemanDiscovery::NodeAPI
  class Inventory < NodeResource
    def url
      @args[:url] + "/inventory"
    end

    def facter
      parse(get({}, "/facter"))
    end
  end
end
