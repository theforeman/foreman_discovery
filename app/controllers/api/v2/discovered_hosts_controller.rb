module Api
  module V2
    class DiscoveredHostsController < ::Api::V2::BaseController
      include Foreman::Controller::DiscoveredExtensions

      before_filter :find_resource, :except => %w{index create facts auto_provision_all reboot_all}
      skip_before_filter :authorize, :only => :facts

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
        end
      end

      api :POST, "/discovered_hosts/", N_("Create a discovered host for testing (use /facts to create new hosts)")
      param_group :discovered_host, :as => :create

      def create
        @discovered_host = Host::Discovered.new(params[:discovered_host])
        process_response @discovered_host.save
      end

      api :PUT, "/discovered_hosts/:id/", N_("Provision a discovered host")
      param :id, :identifier, :required => true
      param :discovered_host, Hash, :action_aware => true do
        param :name, String
        param :environment_id, String
        param :ip, String, :desc => N_("not required if using a subnet with DHCP proxy")
        param :mac, String, :desc => N_("not required if it's a virtual machine")
        param :architecture_id, :number
        param :domain_id, :number
        param :puppet_proxy_id, :number
        param :puppet_class_ids, Array
        param :operatingsystem_id, String
        param :medium_id, :number
        param :ptable_id, :number
        param :subnet_id, :number
        param :sp_subnet_id, :number
        param :model_id, :number
        param :hostgroup_id, :number
        param :owner_id, :number
        param :puppet_ca_proxy_id, :number
        param :image_id, :number
        param :host_parameters_attributes, Array
        param :build, :bool
        param :enabled, :bool
        param :provision_method, String
        param :managed, :bool
        param :progress_report_id, String, :desc => N_("UUID to track orchestration tasks status, GET /api/orchestration/:UUID/tasks")
        param :capabilities, String
        param :root_pass, String, :desc => N_("required if value is not inherited from host group or default password in settings")
      end

      def update
        @host = ::ForemanDiscovery::HostConverter.to_managed(@discovered_host)
        forward_request_url
        update_response = @host.update_attributes(params[:discovered_host])
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
        state = true
        @discovered_host, state = Host::Discovered.import_host_and_facts(params[:facts])
        if Setting['discovery_auto']
          if state && rule = find_discovery_rule(@discovered_host)
            state = perform_auto_provision(@discovered_host, rule)
          else
            Rails.logger.warn "Discovered facts import unsuccessful, skipping auto provisioning"
          end
        end
        process_response state
      rescue Exception => e
        logger.warn "Host discovery failed, facts: #{params[:facts]}"
        logger.debug e.message + "\n" + e.backtrace.join("\n")
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
        Host::Discovered.all.each do |discovered_host|
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
          process_success _("Discovered hosts are rebooting now")
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
