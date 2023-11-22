require 'fast_gettext'
require 'gettext_i18n_rails'
require 'rabl'

module ForemanDiscovery
  #Inherit from the Rails module of the parent app (Foreman), not the plugin.
  #Thus, inherits from ::Rails::Engine and not from Rails::Engine
  class Engine < ::Rails::Engine
    engine_name 'foreman_discovery'

    # support pre-4 Rails versions
    config.autoload_paths += Dir["#{config.root}/app/controllers/foreman_discovery/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/helpers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/services"]

    initializer "foreman_discovery.add_rabl_view_path" do |app|
      Rabl.configure do |config|
        config.view_paths << ForemanDiscovery::Engine.root.join('app', 'views')
      end
    end

    # Add any db migrations
    initializer "foreman_discovery.load_app_instance_data" do |app|
      ForemanDiscovery::Engine.paths['db/migrate'].existent.each do |path|
        app.config.paths['db/migrate'] << path
      end
    end

    initializer 'foreman_discovery.register_plugin', :before => :finisher_hook do |app|
      Foreman::Plugin.register :foreman_discovery do
        requires_foreman '>= 3.8'
        register_gettext

        # settings
        settings do
          category :discovery, N_("Discovery") do
            snippets = Proc.new {
              Hash[ProvisioningTemplate.where(:template_kind => TemplateKind.find_by_name(:snippet)).map{|template| [template[:name], template[:name]]}]
            }

            setting "discovery_location",
              type: :string,
              collection: Proc.new { Hash[[['', '']].concat Location.all.map{|loc| [loc[:title], loc[:title]]}] },
              default: "",
              full_name: N_("Discovery location"),
              description: N_("The default location to place discovered hosts in")

            setting "discovery_organization",
              type: :string,
              collection: Proc.new { Hash[[['', '']].concat Organization.all.map{|org| [org[:title], org[:title]]}] },
              default: "",
              full_name: N_("Discovery organization"),
              description: N_("The default organization to place discovered hosts in")

            setting "discovery_fact",
              type: :string,
              default: "discovery_bootif",
              full_name: N_("Interface fact"),
              description: N_("Fact name to use for primary interface detection")

            setting "discovery_auto_bond",
              type: :boolean,
              default: false,
              full_name: N_("Create bond interfaces"),
              description: N_("Automatic bond interface (if another interface is detected on the same VLAN via LLDP)")

            setting "discovery_clean_facts",
              type: :boolean,
              default: false,
              full_name: N_("Clean all facts"),
              description: N_("Clean all reported facts during provisioning (except discovery facts)")

            setting "discovery_hostname",
              type: :array,
              default: ["discovery_bootif"],
              full_name: N_("Hostname facts"),
              description: N_("List of facts to use for the hostname (first wins)")

            validates "discovery_hostname", presence: true

            setting "discovery_auto",
              type: :boolean,
              default: false,
              full_name: N_("Auto provisioning"),
              description: N_("Automatically provision newly discovered hosts, according to the provisioning rules")

            setting "discovery_reboot",
              type: :boolean,
              default: true,
              full_name: N_("Reboot"),
              description: N_("Automatically reboot or kexec discovered host during provisioning")

            setting "discovery_prefix",
              type: :string,
              default: "mac",
              full_name: N_("Hostname prefix"),
              description: N_("The default prefix to use for the host name, must start with a letter")

            validates "discovery_prefix", presence: true

            setting "discovery_fact_column",
              type: :array,
              default: [],
              full_name: N_("Fact columns"),
              description: N_("Extra facter columns to show in host lists")

            setting "discovery_facts_highlights",
              type: :string,
              default: "",
              full_name: N_("Highlighted facts"),
              description: N_("Regex to organize facts for highlights section - e.g. ^(abc|cde)$")

            setting "discovery_facts_storage",
              type: :string,
              default: "",
              full_name: N_("Storage facts"),
              description: N_("Regex to organize facts for storage section")

            setting "discovery_facts_software",
              type: :string,
              default: "",
              full_name: N_("Software facts"),
              description: N_("Regex to organize facts for software section")

            setting "discovery_facts_hardware",
              type: :string,
              default: "",
              full_name: N_("Hardware facts"),
              description: N_("Regex to organize facts for hardware section")

            setting "discovery_facts_network",
              type: :string,
              default: "",
              full_name: N_("Network facts"),
              description: N_("Regex to organize facts for network section")

            setting "discovery_facts_ipmi",
              type: :string,
              default: "",
              full_name: N_("IPMI facts"),
              description: N_("Regex to organize facts for ipmi section")

            setting "discovery_lock",
              type: :boolean,
              default: false,
              full_name: N_("Lock PXE"),
              description: N_("Automatically generate PXE configuration to pin a newly discovered host to discovery")

            setting "discovery_pxelinux_lock_template",
              type: :string,
              collection: snippets,
              default: "pxelinux_discovery",
              full_name: N_("Locked PXELinux template name"),
              description: N_("PXELinux template to be used when pinning a host to discovery")

            setting "discovery_pxegrub_lock_template",
              type: :string,
              collection: snippets,
              default: "pxegrub_discovery",
              full_name: N_("Locked PXEGrub template name"),
              description: N_("PXEGrub template to be used when pinning a host to discovery")

            setting "discovery_pxegrub2_lock_template",
              type: :string,
              collection: snippets,
              default: "pxegrub2_discovery",
              full_name: N_("Locked PXEGrub2 template name"),
              description: N_("PXEGrub2 template to be used when pinning a host to discovery")

            setting "discovery_always_rebuild_dns",
              type: :boolean,
              default: true,
              full_name: N_("Force DNS"),
              description: N_("Force DNS entries creation when provisioning discovered host")

            setting "discovery_error_on_existing",
              type: :boolean,
              default: false,
              full_name: N_("Error on existing NIC"),
              description: N_("Do not allow to discover existing managed host matching MAC of a provisioning NIC (errors out early)")

            setting "discovery_naming",
              type: :string,
              collection: Proc.new { ::Host::Discovered::NAMING_PATTERNS },
              default: "Fact",
              full_name: N_("Type of name generator"),
              description: N_("Discovery hostname naming pattern")

            setting "discovery_prefer_ipv6",
              type: :boolean,
              default: false,
              full_name: N_("Prefer IPv6"),
              description: N_("Prefer IPv6 to IPv4 when calling discovered nodes")
            end
          end

          # discovered hosts permissions
          security_block :discovery do
            permission :view_discovered_hosts, {
              :discovered_hosts          => [:index, :show, :auto_complete_search, :welcome],
              :"api/v2/discovered_hosts" => [:index, :show],
              :'discovered_hosts/react' => [:index]
            }, :resource_type => 'Host'
            permission :submit_discovered_hosts, {
              :"api/v2/discovered_hosts" => [:facts, :create]
            }, :resource_type => 'Host'
            permission :auto_provision_discovered_hosts, {
              :discovered_hosts          => [:auto_provision,
                                             :multiple_auto_provision,
                                             :submit_multiple_auto_provision],
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
                                             :select_multiple_location,
                                             :refresh_facts,
                                             :reboot,
                                             :multiple_reboot,
                                             :submit_multiple_reboot],
                                             :hosts                     => [:process_hostgroup],
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
            :discovery_rules => [:index, :show, :auto_complete_search, :welcome],
            :"api/v2/discovery_rules" => [:index, :show]
          }, :resource_type => 'DiscoveryRule'
          permission :create_discovery_rules, {
            :discovery_rules => [:new, :create, :clone],
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
          # core permissions
          :view_organizations,
          :view_locations,
          :view_hosts,
          # discovered_hosts
          :view_discovered_hosts,
          # discovered_rules
          :view_discovery_rules,
        ]
        MANAGER = READER + [
          # core permissions
          :create_hosts,
          :edit_hosts,
          :build_hosts,
          :assign_organizations,
          :assign_locations,
          :view_architectures,
          :view_domains,
          :view_hostgroups,
          :view_media,
          :view_models,
          :view_operatingsystems,
          :view_provisioning_templates,
          :view_ptables,
          :view_realms,
          :view_smart_proxies,
          :view_subnets,
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
        if defined?(ForemanPuppet::Engine)
          MANAGER += [ :view_environments, :view_puppetclasses ]
        end
        role "Discovery Reader", READER, "Role granting permissions to view discovered hosts"
        role "Discovery Manager", MANAGER, "Role granting permissions to perform provisioning of discovered hosts"

        add_all_permissions_to_default_roles

        # menu entries
        menu :top_menu, :discovered_hosts, :url_hash => {:controller => :discovered_hosts, :action => :index},
          :caption=> N_('Discovered Hosts'),
          :parent => :hosts_menu,
          :after=>:hosts

        menu :top_menu, :discovery_rules, :url_hash => {:controller => :discovery_rules, :action => :index},
          :caption => N_('Discovery Rules'),
          :parent => :configure_menu,
          :after=> :hostgroups

        # strong parameters
        parameter_filter Subnet, :discovery_id
        parameter_filter Host::Managed, :discovery_rule_id
        parameter_filter Hostgroup, :type, :discovery_rules => [], :discovery_rule_ids => [], :discovery_rule_names => []

        # add dashboard widget
        widget 'discovery_widget', :name=>N_('Discovered Hosts'), :sizex => 6, :sizey =>1

        # apipie API documentation
        # Only available in 1.8, otherwise it has to be in the initializer below
        apipie_documented_controllers ["#{ForemanDiscovery::Engine.root}/app/controllers/api/v2/*.rb"]

        # add discovery smart proxy to subnet
        smart_proxy_for Subnet, :discovery,
          :feature => 'Discovery',
          :label => N_('Discovery Proxy'),
          :description => N_('Discovery Proxy to use within this subnet for managing connection to discovered hosts'),
          :api_description => N_('ID of Discovery Proxy to use within this subnet for managing connection to discovered hosts')
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
      Foreman::Plugin.fact_parser_registry.register(:foreman_discovery, ForemanDiscovery::FactParser)

      # Taxonomy extensions
      ::Location.send :include, DiscoveryTaxonomyExtensions
      ::Organization.send :include, DiscoveryTaxonomyExtensions

      # Model extensions
      ::Host::Managed.send :include, Host::ManagedExtensions
      ::Hostgroup.send :include, HostgroupExtensions
      ::Nic::Managed.send :include, Nic::ManagedExtensions

      # Controller extensions
      ::HostsController.send :include, ForemanDiscovery::Concerns::HostsControllerExtensions
      ::Api::V2::FactValuesController.send :include, Api::V2::FactValuesControllerExtensions

      Foreman::Plugin.fact_importer_registry.register(:foreman_discovery, DiscoveryFactImporter)
    end

    rake_tasks do
      load "discovery.rake"
      Rake::Task['db:seed'].enhance do
        ForemanDiscovery::Engine.load_seed
      end
    end

  end
end
