class RemoveUniqueIndexOnPriority < ActiveRecord::Migration[5.1]
  def change
    remove_index :discovery_rules, :priority
  end
end
