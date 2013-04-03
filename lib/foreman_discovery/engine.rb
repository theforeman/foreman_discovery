require 'foreman_discovery'

module ForemanDiscovery
  #Inherit from the Rails module of the parent app (Foreman), not the plugin.
  #Thus, inherits from ::Rails::Engine and not from Rails::Engine
  class Engine < ::Rails::Engine

    # Include extensions to models in this config.to_prepare block
    config.to_prepare do
      ProxyAPI.send :include, ForemanDiscovery::ProxyAPIExtensions
    end

    initializer 'foreman_discovery.helper' do |app|
      ActionView::Base.send :include, ForemanDiscovery::DiscoveredHelper
    end

    initializer 'foreman_discovery.orchestration' do |app|
      Host::Managed.send(:include, ForemanDiscovery::Orchestration::Reboot) if SETTINGS[:unattended]
    end

  end
end
