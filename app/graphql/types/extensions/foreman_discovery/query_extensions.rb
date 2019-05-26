module Types
  module Extensions
    module ForemanDiscovery
      module QueryExtensions
        extend ActiveSupport::Concern

        included do
          record_field :discovery_rule, Types::DiscoveryRule
          collection_field :discovery_rules, Types::DiscoveryRule
        end
      end
    end
  end
end
