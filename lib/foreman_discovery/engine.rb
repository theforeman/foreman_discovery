require 'foreman_discovery'

module ForemanDiscovery
  #Inherit from the Rails module of the parent app (Foreman), not the plugin.
  #Thus, inherits from ::Rails::Engine and not from Rails::Engine
  class Engine < ::Rails::Engine

    initializer 'foreman_discovery.helper' do |app|
      ActionView::Base.send :include, ForemanDiscovery::DiscoveredHelper
    end

  end
end
