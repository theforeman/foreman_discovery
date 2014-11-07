object @discovered_host

extends "api/v2/discovered_hosts/main"

attributes :environment_id, :environment_name, :sp_mac, :sp_ip, :sp_name, :domain_id, :domain_name,
           :architecture_id, :architecture_name, :operatingsystem_id, :operatingsystem_name,
           :sp_subnet_id, :ptable_id, :ptable_name, :medium_id, :medium_name, :build, :comment, :disk,
           :installed_at, :model_id, :model_name, :hostgroup_id, :hostgroup_name, :owner_id, :owner_type,
           :enabled, :puppet_ca_proxy_id, :managed, :uuid, :capabilities, :provision_method,
           :puppet_proxy_id, :certname, :image_id, :image_name, :created_at, :updated_at,
           :last_compile, :last_freshcheck, :serial, :source_file_id
