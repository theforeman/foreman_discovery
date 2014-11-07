class AddDiscoveryRuleToHost < ActiveRecord::Migration
  def self.up
    add_column :hosts, :discovery_rule_id, :integer
  end

  def self.down
    remove_column :hosts, :discovery_rule_id, :integer
  end
end
