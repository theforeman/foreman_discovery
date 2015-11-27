require 'fast_gettext'
require 'gettext_i18n_rails'
require 'deface'
require 'rabl'

module ForemanDiscovery
  #Inherit from the Rails module of the parent app (Foreman), not the plugin.
  #Thus, inherits from ::Rails::Engine and not from Rails::Engine
  class Engine < ::Rails::Engine

    # support pre-4 Rails versions
    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/helpers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/services"]

    # Load this before the Foreman config initializers, so that the Setting.descendants
    # list includes the plugin STI setting class
    initializer 'foreman_discovery.load_default_settings', :before => :load_config_initializers do |app|
      require_dependency File.expand_path("../../../app/models/setting/discovered.rb", __FILE__) if (Setting.table_exists? rescue(false))
    end

    initializer "foreman_discovery.add_rabl_view_path" do |app|
      Rabl.configure do |config|
        config.view_paths << ForemanDiscovery::Engine.root.join('app', 'views')
      end
    end

    initializer 'foreman_discovery.helper' do |app|
      ActionView::Base.send :include, DiscoveredHostsHelper
    end

    initializer 'foreman_discovery.register_gettext', :after => :load_config_initializers do |app|
      locale_dir = File.join(File.expand_path('../../..', __FILE__), 'locale')
      locale_domain = 'foreman_discovery'

      Foreman::Gettext::Support.add_text_domain locale_domain, locale_dir
    end

    # Add any db migrations
    initializer "foreman_discovery.load_app_instance_data" do |app|
      ForemanDiscovery::Engine.paths['db/migrate'].existent.each do |path|
        app.config.paths['db/migrate'] << path
      end
    end

    initializer 'foreman_discovery.register_plugin', :after=> :finisher_hook do |app|
      Foreman::Plugin.register :foreman_discovery do
        requires_foreman '>= 1.11.0'

        # discovered hosts permissions
        security_block :discovery do
          permission :view_discovered_hosts, {
            :discovered_hosts          => [:index, :show, :auto_complete_search],
            :"api/v2/discovered_hosts" => [:index, :show]
          }, :resource_type => 'Host'
          permission :submit_discovered_hosts, {
            :"api/v2/discovered_hosts" => [:facts, :create]
          }, :resource_type => 'Host'
          permission :auto_provision_discovered_hosts, {
            :discovered_hosts          => [:auto_provision, :auto_provision_all],
            :"api/v2/discovered_hosts" => [:auto_provision, :auto_provision_all]
          }, :resource_type => 'Host'
          permission :provision_discovered_hosts, {
            :discovered_hosts          => [:edit, :update],
            :"api/v2/discovered_hosts" => [:update]
          }, :resource_type => 'Host'
          permission :edit_discovered_hosts, {
            :discovered_hosts          => [:update_multiple_location,
                                           :select_multiple_organization,
                                           :update_multiple_organization,
                                           :select_multiple_location, :refresh_facts, :reboot, :reboot_all],
            :"api/v2/discovered_hosts" => [:refresh_facts, :reboot, :reboot_all]
          }, :resource_type => 'Host'
          permission :destroy_discovered_hosts, {
            :discovered_hosts          => [:destroy, :submit_multiple_destroy, :multiple_destroy],
            :"api/v2/discovered_hosts" => [:destroy]
          }, :resource_type => 'Host'
        end

        # discovery rules permissions
        security_block :discovery_rules do
          permission :view_discovery_rules, {
            :discovery_rules => [:index, :show, :auto_complete_search],
            :"api/v2/discovery_rules" => [:index, :show]
          }, :resource_type => 'DiscoveryRule'
          permission :create_discovery_rules, {
            :discovery_rules => [:new, :create],
            :"api/v2/discovery_rules" => [:create]
          }, :resource_type => 'DiscoveryRule'
          permission :edit_discovery_rules, {
            :discovery_rules => [:edit, :update, :enable, :disable],
            :"api/v2/discovery_rules" => [:create, :update]
          }, :resource_type => 'DiscoveryRule'
          permission :execute_discovery_rules, {
            :discovery_rules => [:auto_provision, :auto_provision_all],
            :"api/v2/discovery_rules" => [:auto_provision, :auto_provision_all]
          }, :resource_type => 'DiscoveryRule'
          permission :destroy_discovery_rules, {
            :discovery_rules => [:destroy],
            :"api/v2/discovery_rules" => [:destroy]
          }, :resource_type => 'DiscoveryRule'
        end

        READER = [
          :view_discovered_hosts,
          :view_discovery_rules,
          :view_organizations,
          :view_locations,
        ]
        MANAGER = READER + [
          :assign_organizations,
          :assign_locations,
          # discovered_hosts
          :submit_discovered_hosts,
          :provision_discovered_hosts,
          :auto_provision_discovered_hosts,
          :edit_discovered_hosts,
          :destroy_discovered_hosts,
          # discovered_rules
          :create_discovery_rules,
          :execute_discovery_rules,
          :edit_discovery_rules,
          :destroy_discovery_rules,
        ]
        role "Discovery Reader", READER
        role "Discovery Manager", MANAGER

        # menu entries
        menu :top_menu, :discovered_hosts, :url_hash => {:controller => :discovered_hosts, :action => :index},
          :caption=> N_('Discovered hosts'),
          :parent => :hosts_menu,
          :after=>:hosts

        menu :top_menu, :discovery_rules, :url_hash => {:controller => :discovery_rules, :action => :index},
          :caption => N_('Discovery rules'),
          :parent => :configure_menu,
          :after=> :hostgroups

        # add dashboard widget
        widget 'discovery_widget', :name=>N_('Discovery widget'), :sizex => 6, :sizey =>1

        # add template helpers
        allowed_template_helpers :rand

        # apipie API documentation
        # Only available in 1.8, otherwise it has to be in the initializer below
        apipie_documented_controllers ["#{ForemanDiscovery::Engine.root}/app/controllers/api/v2/*.rb"]
      end
    end

    initializer "foreman_discovery.apipie" do
      if Apipie.configuration.respond_to?(:checksum_path)
        Apipie.configuration.checksum_path += ['/discovered_hosts/']
      end
    end

    # Include extensions to models in this config.to_prepare block
    config.to_prepare do

      # Fact parsing
      ::FactParser.register_fact_parser(:foreman_discovery, ForemanDiscovery::FactParser)

      # Model extensions
      ::Host::Managed.send :include, Host::ManagedExtensions
      ::Hostgroup.send :include, HostgroupExtensions

      # Include subnet extensions
      ::Subnet.send :include, DiscoverySubnet

      # Include helper for dashboard
      ::DashboardHelper.send(:include, DiscoveredHostsHelper)
    end

    rake_tasks do
      load "discovery.rake"
      Rake::Task['db:seed'].enhance do
        ForemanDiscovery::Engine.load_seed
      end
    end

  end
end
