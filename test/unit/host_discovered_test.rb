require 'test_helper'

class HostDiscoveredTest < ActiveSupport::TestCase
  setup do
    FactoryGirl.create(:setting,
                       :name => 'discovery_fact',
                       :value => 'discovery_bootif',
                       :category => 'Setting::Discovered')
    FactoryGirl.create(:setting,
                       :name => 'discovery_hostname',
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

  test "should setup subnet" do
    raw = parse_json_fixture('/facts.json')
    subnet = FactoryGirl.create(:subnet, :organizations => [Organization.first], :locations => [Location.first])
    Subnet.expects(:subnet_for).with('10.35.27.3').returns(subnet)
    host = Host::Discovered.import_host_and_facts(raw['facts']).first
    assert_equal subnet, host.primary_interface.subnet
  end

  test "should setup subnet with org and loc" do
    org = FactoryGirl.create(:organization, :name => "subnet_org")
    loc = FactoryGirl.create(:location, :name => "subnet_loc")
    FactoryGirl.create(:setting,
                       :name => 'discovery_organization',
                       :value => org.name,
                       :category => 'Setting::Discovered')
    FactoryGirl.create(:setting,
                       :name => 'discovery_location',
                       :value => loc.name,
                       :category => 'Setting::Discovered')
    raw = parse_json_fixture('/facts.json')
    subnet = FactoryGirl.create(:subnet, :organizations => [org], :locations => [loc])
    Subnet.expects(:subnet_for).with('10.35.27.3').returns(subnet)
    host = Host::Discovered.import_host_and_facts(raw['facts']).first
    assert_equal subnet, host.primary_interface.subnet
  end

  test "should raise when fact_name setting isn't present" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_fact] = 'macaddress_foo'
    exception = assert_raises(::Foreman::Exception) do
      Host::Discovered.import_host_and_facts(raw['facts'])
    end
    assert_match(/Expected discovery_fact '\w+' is missing/, exception.message)
  end

  test "should be able to refresh facts" do
    host = Host.create :name => "mydiscoveredhost", :ip => "1.2.3.4", :type => "Host::Discovered"
    raw = parse_json_fixture('/facts.json')
    ::ForemanDiscovery::NodeAPI::Inventory.any_instance.stubs(:facter).returns(raw['facts'])
    assert host.refresh_facts
  end

  test "should create discovered host with hostname if a fact was supplied" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_hostname] = 'somefact'
    facts = raw['facts'].merge({"somefact" => "somename"})
    host = Host::Discovered.import_host_and_facts(facts).first
    assert_equal 'macsomename', host.name
    refute_equal 'e4:1f:13:cc:36:5a', host.mac
  end

  test "should create discovered host with fact_name as a name if it is a valid mac" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_fact] = 'somefact'
    Setting[:discovery_hostname] = 'somefact'
    facts = raw['facts'].merge({"somefact" => "E4:1F:13:CC:36:5A"})
    host = Host::Discovered.import_host_and_facts(facts).first
    assert_equal 'mace41f13cc365a', host.name
    assert_equal 'e4:1f:13:cc:36:5a', host.mac
  end

  test "should create discovered host with default name if fact_name isn't a valid mac" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_fact] = 'lsbdistcodename'
    exception = assert_raises(::Foreman::Exception) do
      Host::Discovered.import_host_and_facts(raw['facts'])
    end
    assert_match(/Unable to detect primary interface using MAC/, exception.message)
  end

  test "should create discovered host with prefix" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_prefix] = 'test'
    host = Host::Discovered.import_host_and_facts(raw['facts']).first
    assert_equal 'teste41f13cc3658', host.name
  end

  test "should create discovered host without prefix" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_prefix] = ''
    host = Host::Discovered.import_host_and_facts(raw['facts']).first
    assert_equal 'e41f13cc3658',host.name
  end

  test "should raise when hostname fact cannot be found" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_hostname] = 'macaddress_foo'
    exception = assert_raises(::Foreman::Exception) do
      Host::Discovered.import_host_and_facts(raw['facts'])
    end
    assert_match(/Invalid facts: hash does not contain a valid value for any of the facts in the discovery_hostname setting:/, exception.message)
  end

  test "should raise when hostname cannot be computed due to normlization and no prefix" do
    raw = parse_json_fixture('/facts.json')
    raw['facts']['invalidhostnamefact'] = '...'
    Setting[:discovery_hostname] = 'invalidhostnamefact'
    Setting[:discovery_prefix] = ''
    exception = assert_raises(::Foreman::Exception) do
      Host::Discovered.import_host_and_facts(raw['facts'])
    end
    assert_match(/Invalid hostname: Could not normalize the hostname/, exception.message)
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

  test "provisioning a discovered host without saving it doesn't create a token" do
    Setting[:token_duration] = 30 #enable tokens so that we only test the CR
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_prefix] = '123'
    host = Host::Discovered.import_host_and_facts(raw['facts']).first
    host.save
    h = ::ForemanDiscovery::HostConverter.to_managed(host)
    refute_valid h
    assert Token.where(:host_id => h.id).empty?
  end

  test "normalization of MAC into a discovered host hostname" do
    assert_equal Host::Discovered.normalize_string_for_hostname("90:B1:1C:54:D5:82"),"90b11c54d582"
  end

  test "normalization of a string containing multiple non-alphabetical characters" do
    assert_equal Host::Discovered.normalize_string_for_hostname(".-_Test::Host.name_-."),"testhostname"
  end

  test "normalization of a valid hostname" do
    assert_equal Host::Discovered.normalize_string_for_hostname("testhostname"),"testhostname"
  end

  test "empty string after hostname normalization should raise an error" do
    exception = assert_raises(::Foreman::Exception) do
      Host::Discovered.normalize_string_for_hostname(".-_")
    end
    assert_match(/Invalid hostname: Could not normalize the hostname/, exception.message)
  end

  test "chooshing the first valid fact from array of fact names" do
    facts = {"custom_hostname" => "testhostname","notmyfact" => "notusedfactvalue"}
    discovery_hostname_fact_array = ['macaddress','custom_hostname','someotherfact']
    assert_equal Host::Discovered.return_first_valid_fact(discovery_hostname_fact_array,facts),"testhostname"
  end

  def parse_json_fixture(relative_path)
    return JSON.parse(File.read(File.expand_path(File.dirname(__FILE__) + relative_path)))
  end
end
