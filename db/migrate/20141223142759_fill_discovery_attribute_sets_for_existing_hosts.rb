class FakeDiscoveredHost < ApplicationRecord
  self.table_name = 'hosts'
end

class FillDiscoveryAttributeSetsForExistingHosts < ActiveRecord::Migration[4.2]
  def up
    FakeDiscoveredHost.where(:type => "Host::Discovered").all.find_each do |host|
      begin
        say "Populating attribute set for discovered host #{host.name}"
        ForemanDiscovery::ImportHooks::DiscoveryAttribute.new(host: host, facts: host.facts_hash).after_populate
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
