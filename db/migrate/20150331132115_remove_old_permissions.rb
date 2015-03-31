class RemoveOldPermissions < ActiveRecord::Migration
  def up
    # remove invalid permissions causing http://projects.theforeman.org/issues/9963
    perms = Permission.where("name like '%_discovered_hosts' and resource_type is null").destroy_all
    puts "Removed invalid permissions: #{perms.inspect}" if perms.size > 0

    # unassociate and remove unused role "Discovery" (renamed to "Discovery Manager")
    if old_role = Role.where(:name => "Discovery").first
      UserRole.where(:role_id => old_role.id).destroy_all
      puts "Role 'Discovery' was removed, use 'Discovery Manager' instead" if old_role.destroy
    end
  end

  def down
  end
end
