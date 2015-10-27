class FillDiscoveryAttributeSetsForExistingHosts < ActiveRecord::Migration
  def up
    Host::Discovered.all.each { |host| host.populate_fields_from_facts}
  end

  def down
  end
end
