class AddMissingViewPermissions < ActiveRecord::Migration
  def up
    permissions = [
      "view_architectures", "view_domains", "view_environments", "view_hosts",
      "view_hostgroups", "view_media", "view_models", "view_operatingsystems",
      "view_provisioning_templates", "view_ptables", "view_puppetclasses",
      "view_realms", "view_smart_proxies", "view_subnets"
    ]
    role = Role.find_by_name("Discovery Reader")
    role.add_permissions!(permissions) if role
    role = Role.find_by_name("Discovery Manager")
    role.add_permissions!(permissions + ["create_hosts"]) if role
  end

  def down
    # not implemented
  end
end
