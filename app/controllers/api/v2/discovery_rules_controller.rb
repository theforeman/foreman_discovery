module Api
  module V2
    class DiscoveryRulesController < ::Api::V2::BaseController
      include Foreman::Controller::Parameters::DiscoveryRule

      before_action :find_resource, :except => %w{index create facts}

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
          param :name, String, :required => true, :desc => N_("represents rule name shown to the users")
          param :search, String, :required => true, :desc => N_("query to match discovered hosts for the particular rule")
          param :hostgroup_id, Integer, :required => true, :desc => N_("the hostgroup that is used to auto provision a host")
          param :hostname, String, :desc => N_("defines a pattern to assign human-readable hostnames to the matching hosts")
          param :max_count, Integer, :desc => N_("enables to limit maximum amount of provisioned hosts per rule")
          param :priority, Integer, :desc => N_("puts the rules in order, low numbers go first. Must be greater then zero")
          param :enabled, :bool, :desc => N_("flag is used for temporary shutdown of rules")
          param :location_ids, Array, :required => true, :desc => N_("location ID for provisioned hosts") if SETTINGS[:locations_enabled]
          param :organization_ids, Array, :required => true, :desc => N_("organization ID for provisioned hosts") if SETTINGS[:organizations_enabled]
        end
      end

      api :POST, "/discovery_rules/", N_("Create a discovery rule")
      param_group :discovery_rule, :as => :create

      def create
        @discovery_rule = DiscoveryRule.new(discovery_rule_params)
        @discovery_rule.priority = DiscoveryRule.suggest_priority if discovery_rule_params[:priority].blank?
        process_response @discovery_rule.save
      end

      api :PUT, "/discovery_rules/:id/", N_("Update a rule")
      param :id, :identifier, :required => true
      param_group :discovery_rule, :as => :update

      def update
        process_response @discovery_rule.update_attributes(discovery_rule_params)
      end

      api :DELETE, "/discovery_rules/:id/", N_("Delete a rule")
      param :id, :identifier, :required => true

      def destroy
        process_response @discovery_rule.destroy
      end

      private

      def resource_class
        DiscoveryRule
      end
    end
  end
end
