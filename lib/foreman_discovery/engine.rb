require 'deface'
require 'fast_gettext'
require 'gettext_i18n_rails'

module ForemanDiscovery
  #Inherit from the Rails module of the parent app (Foreman), not the plugin.
  #Thus, inherits from ::Rails::Engine and not from Rails::Engine
  class Engine < ::Rails::Engine

    # Load this before the Foreman config initializers, so that the Setting.descendants
    # list includes the plugin STI setting class
    initializer 'foreman_discovery.load_default_settings', :before => :load_config_initializers do |app|
      require_dependency File.expand_path("../../../app/models/setting/discovered.rb", __FILE__) if (Setting.table_exists? rescue(false))
    end

    initializer 'foreman_discovery.helper' do |app|
      ActionView::Base.send :include, DiscoveredHostsHelper
    end

    initializer 'foreman_discovery.register_gettext', :after => :load_config_initializers do |app|
      locale_dir = File.join(File.expand_path('../../..', __FILE__), 'locale')
      locale_domain = 'discovery'

      Foreman::Gettext::Support.add_text_domain locale_domain, locale_dir
    end

    initializer 'foreman_discovery.register_plugin', :after=> :finisher_hook do |app|
      Foreman::Plugin.register :foreman_discovery do
        requires_foreman '> 1.4'

        # Add permissions
        security_block :discovery do
          permission :view_discovered_hosts, {:discovered_hosts => [:index, :show, :auto_complete_search, :refresh_facts] }, :resource_type => 'Host'
          permission :provision_discovered_hosts, {:discovered_hosts => [:new, :create] }, :resource_type => 'Host'
          permission :edit_discovered_hosts, {:discovered_hosts => [:edit, :update, :update_multiple_location,
                                                             :select_multiple_organization,
                                                             :update_multiple_organization,
                                                             :select_multiple_location] }, :resource_type => 'Host'
          permission :destroy_discovered_hosts, {:discovered_hosts => [:destroy, :submit_multiple_destroy, :multiple_destroy] }, :resource_type => 'Host'

        end

        # Add a new role called 'Discovery' if it doesn't exist
        role "Discovery", [:view_discovered_hosts, :provision_discovered_hosts, :edit_discovered_hosts, :destroy_discovered_hosts]

        #add menu entry
        menu :top_menu, :discovery, :url_hash => {:controller=> :discovered_hosts, :action=>:index},
             :caption=> N_('Discovered hosts'),
             :parent => :hosts_menu,
             :after=>:hosts

        # add dashboard widget
        widget 'discovery_widget', :name=>N_('Discovery widget'), :sizex => 4, :sizey =>1
      end
    end
    # Include extensions to models in this config.to_prepare block
    config.to_prepare do
      # Include host extensions
      ::Host::Managed.send :include, Host::ManagedExtensions
    end

    rake_tasks do
      load "discovery.rake"
    end

  end
end
