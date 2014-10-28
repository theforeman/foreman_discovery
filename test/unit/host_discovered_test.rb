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
    assert Host::Discovered.find_by_name('macaabbccddeeff')
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

  test "should create discovered host with fact_name as a name" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_fact] = 'lsbdistcodename'
    host = Host::Discovered.import_host_and_facts(raw['facts']).first
    assert_equal 'macsantiago', host.name
  end

  test "should create discovered host with prefix" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_prefix] = 'test'
    Setting[:discovery_fact] = 'lsbdistcodename'
    host = Host::Discovered.import_host_and_facts(raw['facts']).first
    assert_equal 'testsantiago', host.name
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
