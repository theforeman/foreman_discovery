module Foreman::Controller::Parameters::DiscoveredHost
  extend ActiveSupport::Concern
  include Foreman::Controller::Parameters::HostBase

  class_methods do
    def discovered_host_params_filter
      Foreman::ParameterFilter.new(::Host::Discovered).tap do |filter|
        filter.permit :discovery_rule_id

        add_host_base_params_filter(filter)
      end
    end
  end

  def discovered_host_params
    self.class.discovered_host_params_filter.filter_params(params, parameter_filter_context)
  end

  def discovered_host_params_host
    self.class.discovered_host_params_filter.filter_params(params, parameter_filter_context, :host)
  end
end
