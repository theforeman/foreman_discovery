 class AddConstraintsOnDiscoveryRulesHostgroups < ActiveRecord::Migration[4.2]
  def change
    reversible do |dir|
      dir.up do
        DiscoveryRule.unscoped.where("hostgroup_id IS NULL OR hostgroup_id NOT IN (?)", Hostgroup.unscoped.all.pluck(:id)).delete_all
      end
    end
    add_foreign_key "discovery_rules", "hostgroups", name: "discovery_rules_hostgroup_id_fk", :column => "hostgroup_id"
  end
 end
