require 'deface'
require 'discovery_home_helper_patch'

module ForemanDiscovery
  #Inherit from the Rails module of the parent app (Foreman), not the plugin.
  #Thus, inherits from ::Rails::Engine and not from Rails::Engine
  class Engine < ::Rails::Engine

    initializer 'foreman_discovery.helper' do |app|
      ActionView::Base.send :include, DiscoversHelper
    end

    # Include extenstions to models in this config.to_prepare block
    config.to_prepare do
      # Include host extenstions
      ::Host::Managed.send :include, Host::ManagedExtensions
      # Patch the menu
      ::HomeHelper.send :include, DiscoveryHomeHelperPatch
    end


  end
end
