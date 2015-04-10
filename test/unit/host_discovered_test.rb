require 'test_helper'

class HostDiscoveredTest < ActiveSupport::TestCase
  setup do
    User.current = User.find_by_login "admin"
    FactoryGirl.create(:setting,
                       :name => 'discovery_fact',
                       :value => 'discovery_bootif',
                       :category => 'Setting::Discovered')
    FactoryGirl.create(:setting,
                       :name => 'discovery_prefix',
                       :value => 'mac',
                       :category => 'Setting::Discovered')
  end

  test "should be able to create Host::Discovered objects" do
    host = Host.create :name => "mydiscoveredhost", :type => "Host::Discovered"
    assert host.is_a?(Host::Discovered)
  end

  test "should import facts from yaml as Host::Discovered" do
    raw = parse_json_fixture('/facts.json')
    assert Host::Discovered.import_host_and_facts(raw['facts'])
    assert Host::Discovered.find_by_name('mace41f13cc3658')
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
    ForemanDiscovery::ProxyOperations.any_instance.stubs(:parse_get_operation).returns(raw['facts'])
    assert host.refresh_facts
  end

  test "should create discovered host with fact_name as a name if it is a valid mac" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_fact] = 'somefact'
    facts = raw['facts'].merge({"somefact" => "E4:1F:13:CC:36:5A"})
    host = Host::Discovered.import_host_and_facts(facts).first
    assert_equal 'mace41f13cc365a', host.name
    assert_equal 'e4:1f:13:cc:36:5a', host.mac
  end

  test "should create discovered host with default name if fact_name isn't a valid mac" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_fact] = 'lsbdistcodename'
    host = Host::Discovered.import_host_and_facts(raw['facts']).first
    assert_equal 'mace41f13cc3658', host.name
    assert_equal 'e4:1f:13:cc:36:58', host.mac
  end

  test "should create discovered host with prefix" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_prefix] = 'test'
    host = Host::Discovered.import_host_and_facts(raw['facts']).first
    assert_equal 'teste41f13cc3658', host.name
  end

  test "should not name discovered host with prefix that starts with a number, fallback to 'mac'" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_prefix] = '123'
    host = Host::Discovered.import_host_and_facts(raw['facts']).first
    assert host.name.start_with?('mac')
  end

  test "should not name discovered host with prefix that starts with a special character, fallback to 'mac'" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_prefix] = '^abc'
    host = Host::Discovered.import_host_and_facts(raw['facts']).first
    assert host.name.start_with?('mac')
  end

  test "should not name discovered host with prefix that starts with a _, fallback to 'mac'" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_prefix] = '_abc'
    host = Host::Discovered.import_host_and_facts(raw['facts']).first
    assert host.name.start_with?('mac')
  end

  test 'discovered host can be searched in multiple taxonomies' do
    org1 = FactoryGirl.create(:organization)
    org2 = FactoryGirl.create(:organization)
    org3 = FactoryGirl.create(:organization)
    user = FactoryGirl.create(:user, :organizations => [org1, org2])
    host1 = FactoryGirl.create(:host, :type => "Host::Discovered", :organization => org1)
    host2 = FactoryGirl.create(:host, :type => "Host::Discovered", :organization => org2)
    host3 = FactoryGirl.create(:host, :type => "Host::Discovered", :organization => org3)
    hosts = nil

    assert_nil Organization.current
    as_user(user) do
      hosts = Host::Discovered.all
    end
    assert_includes hosts, host1
    assert_includes hosts, host2
    refute_includes hosts, host3

    as_user(:one) do
      hosts = Host::Discovered.all
    end
    assert_includes hosts, host1
    assert_includes hosts, host2
    assert_includes hosts, host3
  end

  def parse_json_fixture(relative_path)
    return JSON.parse(File.read(File.expand_path(File.dirname(__FILE__) + relative_path)))
  end
end
