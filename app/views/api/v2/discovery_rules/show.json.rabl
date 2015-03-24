object @discovery_rule

extends "api/v2/discovery_rules/main"

node do |discovery_rule|
  partial("api/v2/taxonomies/children_nodes", :object => discovery_rule)
end
