class RemoveDiscoveryAttributeSetsFromManagedHosts < ActiveRecord::Migration[4.2]
  def up
    DiscoveryAttributeSet.where(:id => DiscoveryAttributeSet.joins(:host).where(:'hosts.managed' => true).pluck("#{DiscoveryAttributeSet.table_name}.id")).delete_all
  end

  def down
  end
end
