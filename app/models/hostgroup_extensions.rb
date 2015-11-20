module HostgroupExtensions
  extend ActiveSupport::Concern

  included do
    has_many :discovery_rules
    attr_accessible :discovery_rules, :discovery_rule_ids, :discovery_rule_names, :type
  end
end
