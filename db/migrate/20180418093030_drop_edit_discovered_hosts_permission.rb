class DropEditDiscoveredHostsPermission < ActiveRecord::Migration[5.1]
  def up
    Role.ignore_locking do
      edit_discovered_hosts = Permission.find_by_name("edit_discovered_hosts")
      edit_hosts = Permission.find_by_name("edit_hosts")
      unless edit_discovered_hosts.nil?
        Role.unscoped.each do |role|
          role.add_permissions!("edit_hosts") if role.has_permission?(edit_discovered_hosts) && !role.has_permission?(edit_hosts)
        end
        edit_discovered_hosts.destroy
      end
    end
  end

  def down
    # rollback not needed - seed script will add missing permissions
  end
end
