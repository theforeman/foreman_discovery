module DiscoveryFilterExtensions
  extend ActiveSupport::Concern

  included do
    validates_with DiscoveryFilterValidator
  end
end
