class RemoveOldDiscoveryReaderPermissions < ActiveRecord::Migration
  def up
    Permission.where("name like '%_discovery_rules' and resource_type is null").each do |permission|
      permission.update_attributes(:resource_type => 'DiscoveryRule')
    end
  end

  def down
  end
end
