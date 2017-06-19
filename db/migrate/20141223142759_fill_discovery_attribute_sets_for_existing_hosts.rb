class FakeDiscoveredHost < ActiveRecord::Base
  self.table_name = 'hosts'
end

class FillDiscoveryAttributeSetsForExistingHosts < ActiveRecord::Migration
  def up
    FakeDiscoveredHost.where(:type => "Host::Discovered").all.each do |host|
      begin
        say "Populating attribute set for discovered host #{host.name}"
        host.discovery_attribute_set = DiscoveryAttributeSet.where(:host_id => host.id).first_or_create
        host.discovery_attribute_set.update_attributes(host.import_from_facts)
        host.save!
      rescue Exception => e
        say "Error while populating host #{host.name}, deleting: #{e.message}:\n" + e.backtrace.join("\n")
        host.destroy
      end
    end
  end

  def down
  end
end
