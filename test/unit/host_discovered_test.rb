require 'test_helper'

class HostDiscoveredTest < ActiveSupport::TestCase
  setup do
    User.current = User.find_by_login "admin"
  end

  test "should be able to create Host::Discovered objects" do
    host = Host.create :name => "mydiscoveredhost", :type => "Host::Discovered"
    assert host.is_a?(Host::Discovered)
  end

  test "should import facts from yaml as Host::Discovered" do
    assert Host::Discovered.importHostAndFacts(File.read(File.expand_path(File.dirname(__FILE__) + "/facts.yml")))
  end

  test "should be able to refresh facts" do
    host = Host.create :name => "mydiscoveredhost", :ip => "1.2.3.4", :type => "Host::Discovered"
    ForemanDiscovery::Facts.any_instance.stubs(:facts).returns({"macaddress_eth0" => "aa:bb:cc:dd:ee:ff"})
    assert host.refresh_facts
  end

end
