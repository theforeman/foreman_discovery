require 'foreman_discovery'

module ForemanDiscovery
  #Inherit from the Rails module of the parent app (Foreman), not the plugin.
  #Thus, inhereits from ::Rails::Engine and not from Rails::Engine
  class Engine < ::Rails::Engine

    initializer 'foreman_discovery.helper' do |app|
      ActionView::Base.send :include, ForemanDiscovery::HostDiscoveredHelper
    end

    #initializer 'foreman_discovery.controller' do |app|  
    #  ActiveSupport.on_load(:action_controller) do  
    #    include ForemanDiscovery::DiscoveryController
    #  end
    #end

    # Include extensions to models in this config.to_prepare block
    #config.to_prepare do
    #  ::HostsController.send :include, ForemanDiscovery::HostsControllerExtensions
    #end

  end
end
