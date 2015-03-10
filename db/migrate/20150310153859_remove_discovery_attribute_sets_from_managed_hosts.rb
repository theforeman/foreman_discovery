class RemoveDiscoveryAttributeSetsFromManagedHosts < ActiveRecord::Migration
  def up
    DiscoveryAttributeSet.where(:id => DiscoveryAttributeSet.joins(:host).where(:'hosts.managed' => true).pluck(:id)).delete_all
  end

  def down
  end
end
