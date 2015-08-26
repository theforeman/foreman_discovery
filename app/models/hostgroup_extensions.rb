module HostgroupExtensions
  extend ActiveSupport::Concern

  included do
    has_many :discovery_rules, :dependent => :restrict_with_error
    attr_accessible :discovery_rules, :discovery_rule_ids, :discovery_rule_names, :type
  end
end
