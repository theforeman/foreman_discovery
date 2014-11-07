class CreateDiscoveryRules < ActiveRecord::Migration
  def change
    create_table :discovery_rules do |t|
      t.string :name, :length => 254
      t.string :query, :length => 254
      t.integer :hostgroup_id, :null => false
      t.string :hostname, :length => 254
      t.integer :max_count, :default => 0
      t.integer :priority, :default => 0
      t.boolean :enabled, :default => true

      t.timestamps
    end
  end
end
