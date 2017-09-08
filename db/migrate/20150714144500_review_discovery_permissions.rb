class ReviewDiscoveryPermissions < ActiveRecord::Migration
  def up
    Role.ignore_locking do
      if (mgr = Role.find_by_name("Discovery Manager"))
        perms = []
        perms << "submit_discovered_hosts" if Permission.find_by_name("edit_discovered_hosts")
        perms << "auto_provision_discovered_hosts" if Permission.find_by_name("provision_discovered_hosts")
        perms << "create_discovery_rules" if Permission.find_by_name("new_discovery_rules")
        perms << "destroy_discovery_rules" if Permission.find_by_name("delete_discovery_rules")
        mgr.add_permissions!(perms)
      end
    end
    Permission.find_by_name("new_discovery_rules").try(:destroy)
  end

  def down
    # rollback is not supported
  end
end
