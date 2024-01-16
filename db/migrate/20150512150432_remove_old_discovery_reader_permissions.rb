class RemoveOldDiscoveryReaderPermissions < ActiveRecord::Migration[4.2]
  def up
    Permission.where("name like '%_discovery_rules' and resource_type is null").find_each do |permission|
      permission.update(:resource_type => 'DiscoveryRule')
    end
  end

  def down
  end
end
