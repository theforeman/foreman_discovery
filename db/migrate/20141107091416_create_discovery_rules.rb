class CreateDiscoveryRules < ActiveRecord::Migration[4.2]
  def change
    create_table :discovery_rules do |t|
      t.string :name, :length => 254
      t.string :search, :length => 254
      t.integer :hostgroup_id, :null => false
      t.string :hostname, :length => 254, :default => ''
      t.integer :max_count, :default => 0
      t.integer :priority, :default => 0
      t.boolean :enabled, :default => true, :null => false

      t.timestamps :null => false
    end
  end
end
