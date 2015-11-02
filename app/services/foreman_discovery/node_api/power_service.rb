module ForemanDiscovery::NodeAPI
  class PowerService < NodeResource
    def url
      @args[:url] + "/power"
    end

    def reboot
      put({}, "/reboot")
    end

    def kexec(json)
      put(json, "/kexec")
    end

  end
end
