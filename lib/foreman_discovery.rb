module ForemanDiscovery
  if defined?(Rails) && Rails::VERSION::MAJOR == 3
    require 'foreman_discovery/engine'
  end
end
