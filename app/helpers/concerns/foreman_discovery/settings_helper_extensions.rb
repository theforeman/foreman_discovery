module ForemanDiscovery
  module SettingsHelperExtensions
    extend ActiveSupport::Concern

    included do
      alias_method_chain :value, :discovery
    end

    def value_with_discovery(setting)
      return value_without_discovery(setting) unless [
        'discovery_location',
        'discovery_organization'].include?(setting.name)

      case setting.name
      when "discovery_location"
        edit_select(
          setting,
          :value,
          :select_values => discovery_taxonomy_values(Location))
      when "discovery_organization"
        edit_select(
          setting,
          :value,
          :select_values => discovery_taxonomy_values(Organization))
      end
    end

    private

    def discovery_taxonomy_values(taxonomy_class)
      Hash[taxonomy_class.all.map{ |org| [org[:title], org[:title]] }].to_json
    end
  end
end
