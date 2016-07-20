module HostgroupExtensions
  extend ActiveSupport::Concern

  included do
    has_many :discovery_rules, :dependent => :restrict_with_error
  end
end
