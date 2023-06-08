class DiscoveryAttributeSet < ApplicationRecord
  belongs_to :host, :class_name => "Host::Discovered"

  validates :cpu_count, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :memory, :presence => true,    :numericality => {:greater_than_or_equal_to => 0}
end
