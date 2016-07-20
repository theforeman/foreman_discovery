module DiscoverySubnet
  extend ActiveSupport::Concern
  included do
    belongs_to :discovery, :class_name => "SmartProxy"
  end
end

