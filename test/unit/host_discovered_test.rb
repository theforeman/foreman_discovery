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
    assert Host::Discovered.find_by_name('macaabbccddeef5')
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
    facts = raw['facts'].merge({"somefact" => "bb:aa:cc:dd:ee:ff"})
    host = Host::Discovered.import_host_and_facts(facts).first
    assert_equal 'macbbaaccddeeff', host.name
    assert_equal 'bb:aa:cc:dd:ee:ff', host.mac
  end

  test "should create discovered host with default name if fact_name isn't a valid mac" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_fact] = 'lsbdistcodename'
    host = Host::Discovered.import_host_and_facts(raw['facts']).first
    assert_equal 'macaabbccddeef5', host.name
    assert_equal 'aa:bb:cc:dd:ee:f5', host.mac
  end

  test "should create discovered host with prefix" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_prefix] = 'test'
    host = Host::Discovered.import_host_and_facts(raw['facts']).first
    assert_equal 'testaabbccddeef5', host.name
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

  def parse_json_fixture(relative_path)
    return JSON.parse(File.read(File.expand_path(File.dirname(__FILE__) + relative_path)))
  end

end
