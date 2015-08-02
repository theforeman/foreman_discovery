object @discovered_host

extends "api/v2/discovered_hosts/base"

attributes :ip, :mac, :last_report, :subnet_id, :subnet_name, :model_name, :memory, :disk_count, :disks_size
attribute :cpu_count => :cpus

if SETTINGS[:organizations_enabled]
  attributes :organization_id, :organization_name
end

if SETTINGS[:locations_enabled]
  attributes :location_id, :location_name
end
