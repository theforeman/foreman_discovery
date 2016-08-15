module Foreman::Controller::Parameters::DiscoveryRule
  extend ActiveSupport::Concern
  include Foreman::Controller::Parameters::Taxonomix

  class_methods do
    def discovery_rule_params_filter
      Foreman::ParameterFilter.new(::DiscoveryRule).tap do |filter|
        filter.permit :name, :search, :hostname, :priority, :enabled, :hostgroup, :hostgroup_id, :max_count
        add_taxonomix_params_filter(filter)
      end
    end
  end

  def discovery_rule_params
    self.class.discovery_rule_params_filter.filter_params(params, parameter_filter_context)
  end
end
