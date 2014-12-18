class DiscoveryAttributeSet < ActiveRecord::Base
  belongs_to :host, :class_name => "Host::Discovered", :foreign_key => :host_id
  attr_accessible :cpu_count, :disk_count, :disks_size, :memory

  validates :cpu_count, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :memory, :presence => true,    :numericality => {:greater_than_or_equal_to => 0}
  validates :host, :presence => true
end
