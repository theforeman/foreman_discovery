module DiscoveryTaxonomyExtensions
  extend ActiveSupport::Concern
  included do
    has_many :discovered_hosts, :class_name => 'Host::Discovered'
    before_destroy ActiveRecord::Base::EnsureNotUsedBy.new(:discovered_hosts)
  end
end
