require 'deface'
require 'discovery_home_helper_patch'
require 'fast_gettext'
require 'gettext_i18n_rails'

module ForemanDiscovery
  #Inherit from the Rails module of the parent app (Foreman), not the plugin.
  #Thus, inherits from ::Rails::Engine and not from Rails::Engine
  class Engine < ::Rails::Engine

    # Load this before the Foreman config initizializers, so that the Setting.descendants
    # list includes the plugin STI setting class
    initializer 'foreman_discovery.load_default_settings', :before => :load_config_initializers do |app|
      require_dependency File.expand_path("../../../app/models/setting/discovered.rb", __FILE__) if (Setting.table_exists? rescue(false))
    end

    initializer 'foreman_discovery.helper' do |app|
      ActionView::Base.send :include, DiscoversHelper
    end

    initializer 'foreman_discovery.register_gettext', :after => :load_config_initializers do |app|
      locale_dir = File.join(File.expand_path('../../..', __FILE__), 'locale')
      locale_domain = 'discovery'

      Foreman::Gettext::Support.add_text_domain locale_domain, locale_dir
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
