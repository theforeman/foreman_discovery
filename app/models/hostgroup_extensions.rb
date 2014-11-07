module HostgroupExtensions
  extend ActiveSupport::Concern

  included do
    has_many :discovery_rules
  end
end
