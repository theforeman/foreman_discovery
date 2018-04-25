module ForemanDiscovery

  class FactImporter < ::FactImporter
    def fact_name_class
      FactName
    end
  end

end
