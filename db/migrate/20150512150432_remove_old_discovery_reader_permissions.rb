class RemoveOldDiscoveryReaderPermissions < ActiveRecord::Migration
  def up
    Permission.where("name like '%_discovery_rules' and resource_type is null").destroy_all
  end

  def down
  end
end

