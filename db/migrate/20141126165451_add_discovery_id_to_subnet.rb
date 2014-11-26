class AddDiscoveryIdToSubnet < ActiveRecord::Migration
  def self.up
    add_column :subnets, :discovery_id, :integer
  end

  def self.down
    remove_column :subnets, :discovery_id
  end
end