require 'deface'
require 'discovery_home_helper_patch'

module ForemanDiscovery
  #Inherit from the Rails module of the parent app (Foreman), not the plugin.
  #Thus, inherits from ::Rails::Engine and not from Rails::Engine
  class Engine < ::Rails::Engine

    # Load this before the Foreman config initizializers, so that the Setting.descendants
    # list includes the plugin STI setting class
    initializer 'foreman_discovery.load_default_settings', :before => :load_config_initializers do |app|
      require_dependency File.expand_path("../../../app/models/setting/discovered.rb", __FILE__)
    end

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

    rake_tasks do
      load "tasks.rake"
    end

  end
end
