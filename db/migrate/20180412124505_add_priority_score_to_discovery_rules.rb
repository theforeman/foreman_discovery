 class AddPriorityScoreToDiscoveryRules < ActiveRecord::Migration[4.2]
  class DiscoveryRules < ActiveRecord::Base
  end

  def up
    # to make enough room to future entries. set initial score and delta to 100
    delta = score = 100
    # This loop keeps the same priority behavior before migration
    # and makes sure there are no two entities with the same priority.
    DiscoveryRules.reset_column_information
    DiscoveryRules.unscoped.reorder(:priority, :created_at).find_each do |rule|
      rule.update!(:priority => score)
      score += delta
    end
    change_column :discovery_rules, :priority, :integer, null: false
    add_index :discovery_rules, :priority, unique: true
  end

  def down
    remove_index :discovery_rules, :priority
    change_column :discovery_rules, :priority, :integer, default: 0
  end

 end
