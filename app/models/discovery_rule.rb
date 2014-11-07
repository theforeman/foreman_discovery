class DiscoveryRule < ActiveRecord::Base
  attr_accessible :enabled, :hostgroup_id, :hostname, :max_count, :name, :priority, :query

  belongs_to :hostgroup
  has_many :hosts
end
