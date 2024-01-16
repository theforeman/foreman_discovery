module Api
  module V2
    class DiscoveredHostsController < ::Api::V2::BaseController
      include Foreman::Controller::Parameters::DiscoveredHost
      include Foreman::Controller::DiscoveredExtensions

      before_action :find_resource, :except => %w{index create facts auto_provision_all reboot_all}
      skip_before_action :authorize, :only => :facts

      resource_description do
        resource_id 'discovered_hosts'
        api_version 'v2'
        api_base_url "/api/v2"
      end

      api :GET, "/discovered_hosts/", N_("List all discovered hosts")
      param :search, String, :desc => N_("filter results")
      param :order, String, :desc => N_("sort results")
      param :page, String, :desc => N_("paginate results")
      param :per_page, String, :desc => N_("number of entries per request")

      def index
        @discovered_hosts = resource_scope.search_for(*search_options).paginate(paginate_options)
      end

      api :GET, "/discovered_hosts/:id/", N_("Show a discovered host")
      param :id, :identifier_dottable, :required => true

      def show
      end

      def_param_group :discovered_host do
        param :discovered_host, Hash, :action_aware => true do
          param :name, String, :required => true
          param :ip, String, :required => true
          param :mac, String, :required => true
          param :pxe_loader, Operatingsystem.all_loaders, :desc => N_("DHCP filename option (Grub2 or PXELinux by default)")
        end
      end

      api :POST, "/discovered_hosts/", N_("Create a discovered host for testing (use /facts to create new hosts)")
      param_group :discovered_host, :as => :create

      def create
        @discovered_host = Host::Discovered.new(discovered_host_params)
        @discovered_host.suggest_default_pxe_loader if params[:discovered_host] && params[:discovered_host][:pxe_loader].nil?
        process_response @discovered_host.save
      end

      api :PUT, "/discovered_hosts/:id/", N_("Provision a discovered host")
      param :id, :identifier, :required => true
      param :discovered_host, Hash, :action_aware => true do
        param :name, String
        param :environment_id, String, :desc => N_("required if host is managed and value is not inherited from host group")
        param :ip, String, :desc => N_("not required if using a subnet with DHCP proxy")
        param :mac, String, :desc => N_("not required if it's a virtual machine")
        param :architecture_id, :number, :desc => N_("required if host is managed and value is not inherited from host group")
        param :domain_id, :number, :desc => N_("required if host is managed and value is not inherited from host group")
        param :puppet_proxy_id, :number
        param :puppet_class_ids, Array
        param :operatingsystem_id, :number, :desc => N_("required if host is managed and value is not inherited from host group")
        param :medium_id, String, :desc => N_("required if not imaged based provisioning and host is managed and value is not inherited from host group")
        param :ptable_id, :number, :desc => N_("required if host is managed and custom partition has not been defined")
        param :subnet_id, :number, :desc => N_("required if host is managed and value is not inherited from host group")
        param :sp_subnet_id, :number
        param :model_id, :number
        param :hostgroup_id, :number
        param :owner_id, :number
        param :owner_type, Host::Base::OWNER_TYPES, :desc => N_("Host's owner type")
        param :puppet_ca_proxy_id, :number
        param :image_id, :number
        param :host_parameters_attributes, Array, :desc => N_("Host's parameters (array or indexed hash)") do
          param :name, String, :desc => N_("Name of the parameter"), :required => true
          param :value, String, :desc => N_("Parameter value"), :required => true
          param :parameter_type, Parameter::KEY_TYPES, :desc => N_("Type of value")
          param :hidden_value, :bool
        end
        param :build, :bool
        param :enabled, :bool
        param :provision_method, String
        param :managed, :bool
        param :progress_report_id, String, :desc => N_("UUID to track orchestration tasks status, GET /api/orchestration/:UUID/tasks")
        param :capabilities, String
        param :root_pass, String, :desc => N_("required if value is not inherited from host group or default password in settings")
        param :pxe_loader, Operatingsystem.all_loaders, :desc => N_("DHCP filename option (Grub2 or PXELinux by default)")
      end

      def update
        @host = ::ForemanDiscovery::HostConverter.to_managed(@discovered_host, true, managed_host_params[:build], managed_host_params)
        forward_request_url
        update_response = @host.save
        process_response update_response
      end

      api :DELETE, "/discovered_hosts/:id/", N_("Delete a discovered host")
      param :id, :identifier, :required => true

      def destroy
        process_response @discovered_host.destroy
      end

      api :POST, "/discovered_hosts/facts", N_("Upload facts for a host, creating the host if required")
      param :facts, Hash, :required => true, :desc => N_("hash containing facts for the host with minimum set of facts: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (example in case primary interface is named eth0)")

      def facts
        # creating a host from facts is not a mass assignment - we store them individually
        facts = params['facts'].to_unsafe_h
        state = true
        User.as_anonymous_admin do
          @discovered_host = Host::Discovered.import_host(facts)
          # Host::Based.set_taxonomies sets taxonomies during import from either
          # facts or via Global Foreman setting "default_taxonomy", reset it back so
          # the anonymous admin can see all records. We set taxonomy explicitly via
          # discovery SubnetAndTaxonomy import hook and enforce taxnomy manually
          # in find_discovery_rule method via validate_rule_by_taxonomy.
          Taxonomy.no_taxonomy_scope do
            Rails.logger.warn 'Discovered facts import unsuccessful, skipping auto provisioning' unless @discovered_host
            if Setting['discovery_auto'] && @discovered_host && (rule = find_discovery_rule(@discovered_host))
              state = perform_auto_provision(@discovered_host, rule)
            end
          end
        end
        process_response state
      rescue Exception => e
        ForemanDiscovery::UINotifications::FailedDiscovery.new(e).deliver!
        Foreman::Logging.exception("Host discovery failed, facts: #{facts}", e)
        render :json => {'message'=>e.to_s}, :status => :unprocessable_entity
      end

      api :POST, "/discovered_hosts/:id/auto_provision", N_("Execute rules against a discovered host")
      param :id, :identifier, :required => true

      def auto_provision
        if rule = find_discovery_rule(@discovered_host)
          if perform_auto_provision(@discovered_host, rule)
            msg = _("Host %{host} was provisioned with rule %{rule}") % {:host => @discovered_host.name, :rule => rule.name}
            render :json => {:message => msg}
          else
            msg = _("Unable to provision %{host}: %{errors}") % {:host => @discovered_host.name, :errors => @discovered_host.errors.full_messages.join(' ')}
            render :json => {:message => msg}, :status => :unprocessable_entity
          end
        else
          render_error :custom_error, :status => :not_found,
                       :locals => {
                           :message => _("No rule found for host %s") % @discovered_host.name
                       }
        end
      rescue ::Foreman::Exception => e
        render :json => {'message' => e.to_s}, :status => :unprocessable_entity
      end

      api :POST, "/discovered_hosts/auto_provision_all", N_("Execute rules against all currently discovered hosts")

      def auto_provision_all
        result = true
        error_message = _("Errors during auto provisioning: %s")

        if Host::Discovered.count == 0
          error_message = _("No discovered hosts to provision")
          result = false
        end

        total_count = 0
        overall_errors = ""
        Host::Discovered.all.find_each do |discovered_host|
          if rule = find_discovery_rule(discovered_host)
            result &= perform_auto_provision(discovered_host, rule)
            unless discovered_host.errors.empty?
              errors = discovered_host.errors.full_messages.join(' ')
              logger.warn "Failed to auto provision host %s: %s" % [discovered_host.name, errors]
              overall_errors << "#{discovered_host.name}: #{errors} "
            else
              total_count += 1
            end
          else
            logger.warn "No rule found for host %s" % discovered_host.name
          end
        end

        if result
          msg = _("%s discovered hosts were provisioned") % total_count
          render :json => {:message => msg}
        else
          render_error :custom_error,
            :status => :unprocessable_entity,
            :locals => {
              :message => error_message % overall_errors
            }
        end
      end

      api :PUT, "/discovered_hosts/:id/refresh_facts", N_("Refreshing the facts of a discovered host")
      param :id, :identifier, :required => true

      def refresh_facts
        process_response @discovered_host.refresh_facts
      rescue ::Foreman::Exception => e
        render :json => { 'message' => e.to_s }
      end

      api :PUT, "/discovered_hosts/:id/reboot", N_("Rebooting a discovered host")
      param :id, :identifier, :required => true

      def reboot
        process_response @discovered_host.reboot
      rescue ::Foreman::Exception => e
        render :json => {'message'=>e.to_s}
      end

      api :PUT, "/discovered_hosts/reboot_all", N_("Rebooting all discovered hosts")

      def reboot_all
        error_message = perform_reboot_all
        if error_message
          render_error :custom_error,
                       :status => :unprocessable_entity,
                       :locals => {
                           :message => error_message
                       }
        else
          process_success :success_msg => _("Discovered hosts are rebooting now")
        end
      end

      private

      def resource_class
        Host::Discovered
      end

      def forward_request_url
        @discovered_host.request_url = request.host_with_port if @discovered_host.respond_to?(:request_url)
      end

      def action_permission
        case params[:action]
          when 'auto_provision', 'auto_provision_all'
            :auto_provision
          when 'refresh_facts', 'reboot', 'reboot_all'
            :edit
          when 'facts', 'create'
            :submit
          else
            super
        end
      end
    end
  end
end
