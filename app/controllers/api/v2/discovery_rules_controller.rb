module Api
  module V2
    class DiscoveryRulesController < ::Api::V2::BaseController

      before_filter :find_resource, :except => %w{index create facts}

      resource_description do
        resource_id 'discovery_rules'
        api_version 'v2'
        api_base_url "/api/v2"
      end

      api :GET, "/discovery_rules/", N_("List all discovery rules")
      param :search, String, :desc => N_("filter results")
      param :order, String, :desc => N_("sort results")
      param :page, String, :desc => N_("paginate results")
      param :per_page, String, :desc => N_("number of entries per request")

      def index
        @discovery_rules = resource_scope.search_for(*search_options).paginate(paginate_options)
      end

      api :GET, "/discovery_rules/:id/", N_("Show a discovery rule")
      param :id, :identifier_dottable, :required => true

      def show
      end

      def_param_group :discovery_rule do
        param :discovery_rule, Hash, :action_aware => true do
          param :name, String, :required => true
          param :query, String, :required => true
          param :hostgroup_id, Integer, :required => true
          param :hostname, String, :required => true
          param :max_count, Integer
          param :priority, Integer
          param :enabled, Boolean
        end
      end

      api :POST, "/discovery_rules/", N_("Create a discovery rule")
      param_group :discovery_rule, :as => :create

      def create
        @discovery_rule = DiscoveryRule.new(params[:discovery_rule])
        process_response @discovery_rule.save
      end

      api :PUT, "/discovery_rules/:id/", N_("Update a rule")
      param :id, :identifier, :required => true
      param :discovery_rule, Hash, :action_aware => true do
          param :name, String, :required => true
          param :query, String, :required => true
          param :hostgroup_id, Integer, :required => true
          param :hostname, String, :required => true
          param :max_count, Integer
          param :priority, Integer
          param :enabled, Boolean
      end

      def update
        process_response @discovery_rule.update_attributes(params[:discovery_rule])
      end

      api :DELETE, "/discovery_rules/:id/", N_("Delete a rule")
      param :id, :identifier, :required => true

      def destroy
        process_response @discovery_rule.destroy
      end

      api :POST, "/discovery_rules/execute", N_("Execute rules against currently discovered hosts")

      def execute
        ForemanDiscovery.execute_auto_provisioning
      rescue ::Foreman::Exception => e
        render :json => {'message'=>e.to_s}, :status => :unprocessable_entity
      end

      private

      def resource_class
        DiscoveryRule
      end

    end
  end
end
