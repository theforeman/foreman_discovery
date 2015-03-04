object @discovery_rule

extends "api/v2/discovery_rules/base"

attributes :name, :enabled, :hostgroup_id, :hostgroup_name, :hostname, :priority, :search
attribute :max_count => :hosts_limit

child :hosts do
  extends "api/v2/discovered_hosts/base"
end
