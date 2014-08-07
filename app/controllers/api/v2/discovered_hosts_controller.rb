module Api
  module V2
    class DiscoveredHostsController < ::Api::V2::BaseController

      before_filter :find_resource, :except => %w{index create facts}
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

      api :POST, "/discovered_hosts/", N_("Create a discovered host")
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
      end

      def update
        @host         = @discovered_host.becomes(::Host::Managed)
        @host.type    = 'Host::Managed'
        @host.managed = true
        @host.build   = true
        forward_request_url
        process_response @host.update_attributes(params[:discovered_host])
      end

      api :DELETE, "/discovered_hosts/:id/", N_("Delete a discovered host")
      param :id, :identifier, :required => true

      def destroy
        process_response @discovered_host.destroy
      end

      api :POST, "/discovered_hosts/facts", N_("Upload facts for a host, creating the host if required")
      param :facts, Hash, :required => true, :desc => N_("hash containing facts for the host")

      def facts
        @discovered_host, state = Host::Discovered.import_host_and_facts(params[:facts])
        process_response state
      rescue ::Foreman::Exception => e
        render :json => {'message'=>e.to_s}, :status => :unprocessable_entity
      end

      private

      def resource_class
        Host::Discovered
      end

      def forward_request_url
        @discovered_host.request_url = request.host_with_port if @discovered_host.respond_to?(:request_url)
      end

    end
  end
end
