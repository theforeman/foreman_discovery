require 'test_helper'

class HostDiscoveredTest < ActiveSupport::TestCase
  setup do
    User.current = User.find_by_login "admin"
    FactoryGirl.create(:setting,
                       name: 'discovery_fact',
                       value: 'macaddress',
                       category: 'Setting::Discovered')
  end

  test "should be able to create Host::Discovered objects" do
    host = Host.create :name => "mydiscoveredhost", :type => "Host::Discovered"
    assert host.is_a?(Host::Discovered)
  end

  test "should import facts from yaml as Host::Discovered" do
    raw = parse_json_fixture('/facts.json')
    assert Host::Discovered.import_host_and_facts(raw['facts'])
  end

  test "should raise when fact_name setting isn't present" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_fact] = 'macaddress_foo'
    assert_raises Foreman::Exception do
      Host::Discovered.import_host_and_facts(raw['facts'])
    end
  end

  test "should be able to refresh facts" do
    host = Host.create :name => "mydiscoveredhost", :ip => "1.2.3.4", :type => "Host::Discovered"
    raw = parse_json_fixture('/facts.json')
    ForemanDiscovery::Facts.any_instance.stubs(:facts).returns(raw['facts'])
    assert host.refresh_facts
  end

  def parse_json_fixture(relative_path)
    return JSON.parse(File.read(File.expand_path(File.dirname(__FILE__) + relative_path)))
  end

end
