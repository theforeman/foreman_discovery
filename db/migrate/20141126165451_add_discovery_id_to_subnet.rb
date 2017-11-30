class AddDiscoveryIdToSubnet < ActiveRecord::Migration[4.2]
  def self.up
    add_column :subnets, :discovery_id, :integer
  end

  def self.down
    remove_column :subnets, :discovery_id
  end
end