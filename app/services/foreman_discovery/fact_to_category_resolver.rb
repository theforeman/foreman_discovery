module ForemanDiscovery
  class FactToCategoryResolver
    include ActionView::Helpers::NumberHelper

    attr_reader :categories, :interfaces

    CATEGORIES_NAMES = [N_("Highlights"),
                        N_("Storage"),
                        N_("Hardware"),
                        N_("Network"),
                        N_("Software"),
                        N_("IPMI"),
                        N_("Miscellaneous")].freeze

    def initialize(host)
      categories = [:highlights, :storage, :hardware, :network, :software, :ipmi]

      @regex_array = categories.map do |category|
        settings_category = settings_discovery_fact_prefix(category)
        if settings_category.empty?
          send(category)
        else
          Regexp.new(settings_category)
        end
      end

      @regex_array << false

      @categories = []

      @interfaces = host.interfaces.map do |interface|
        {
          identifier: interface["identifier"],
          type: interface["type"],
          mac: interface["mac"],
          ip: interface["ip"] || "N/A",
          primary: interface["primary"],
          provision: interface["provision"],
        }
      end

      assign_facts(host)
    end

    private

    def assign_facts(host)
      host.facts_hash.each do |key, value|
        value = number_to_human_size(value) if /size$/ =~ key
        assign_fact_to_category(key, value)
      end

      return if host.primary_interface.subnet.nil?

      discovery_subnet = "#{host.primary_interface.subnet.name} (#{host.primary_interface.subnet.network})"
      assign_fact_to_category("discovery_subnet", discovery_subnet)
    end

    def assign_fact_to_category(key, value)
      if @interfaces.any? { |interface| key.include? interface[:identifier] }
        @categories[3] = {} if @categories[3].nil?
        @categories[3][key] = value
        return
      end

      @regex_array.each_with_index do |regex, index|
        @categories[index] = {} if @categories[index].nil?
        if !regex
          @categories[index][key] = value
        elsif regex.match key
          @categories[index][key] = value
          break
        end
      end
    end

    def highlights
      /^(productname|memorysize|manufacturer|architecture|macaddress$|processorcount|physicalprocessorcount|discovery_subnet|discovery_boot|ipaddress$)/
    end

    def storage
      /^blockdevice/
    end

    def hardware
      /^(hardw|manufacturer|memo|process)/
    end

    def network
      /^(interfaces|dhcp|fqdn|hostname)/
    end

    def software
      /^(bios|os|discovery)/
    end

    def ipmi
      /^ipmi/
    end

    def settings_discovery_fact_prefix(name)
      Setting["discovery_facts_#{name}".to_sym]
    end
  end
end
