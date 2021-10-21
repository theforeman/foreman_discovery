module Foreman::Controller::Parameters::DiscoveredHost
  extend ActiveSupport::Concern
  include Foreman::Controller::Parameters::Host
  if defined?(ForemanPuppet)
    include ForemanPuppet::Extensions::ParametersHost
  end

  class_methods do
    def discovered_host_params_filter
      Foreman::ParameterFilter.new(::Host::Discovered).tap do |filter|
        filter.permit :discovery_rule_id

        add_host_base_params_filter(filter)
        add_host_common_params_filter(filter)
        add_host_puppet_params_filter(filter) if defined?(ForemanPuppet)
      end
    end
  end

  def discovered_host_params
    filtered_params = self.class.discovered_host_params_filter.filter_params(params, parameter_filter_context)
    process_deprecated_puppet_params!(filtered_params) if defined?(ForemanPuppet)
    filtered_params
  end

  def discovered_host_params_host
    filtered_params = self.class.discovered_host_params_filter.filter_params(params, parameter_filter_context, :host)
    process_deprecated_puppet_params!(filtered_params) if defined?(ForemanPuppet)
    filtered_params
  end

  def managed_host_params_host
    filtered_params = self.class.host_params_filter.filter_params(params, parameter_filter_context, :host)
    process_deprecated_puppet_params!(filtered_params) if defined?(ForemanPuppet)
    filtered_params
  end

  def managed_host_params
    filtered_params = self.class.host_params_filter.filter_params(params, parameter_filter_context)
    process_deprecated_puppet_params!(filtered_params) if defined?(ForemanPuppet)
    filtered_params
  end
end
