require 'test_plugin_helper'

class HostDiscoveredTest < ActiveSupport::TestCase
  setup do
    set_default_settings
  end

  test "should be able to create Host::Discovered objects" do
    host = Host.create :name => "mydiscoveredhost", :type => "Host::Discovered"
    assert host.is_a?(Host::Discovered)
  end

  test "should import facts from yaml as Host::Discovered" do
    raw = parse_json_fixture('/facts.json')
    assert Host::Discovered.import_host(raw['facts'])
    assert Host::Discovered.find_by_name('mace41f13cc3658')
  end

  test 'fact value association is set accordingly' do
    discovered_host = FactoryGirl.create(:discovered_host, :with_facts, :fact_count => 1)
    fact_value = discovered_host.fact_values.first
    assert_equal discovered_host.id, fact_value.host.id
  end

  test "should setup subnet" do
    raw = parse_json_fixture('/facts.json')
    subnet = FactoryGirl.create(:subnet_ipv4, :name => 'Subnet99', :network => '10.35.27.0', :organizations => [organization_one], :locations => [location_one])
    Subnet.expects(:subnet_for).with('10.35.27.3').returns(subnet)
    host = Host::Discovered.import_host(raw['facts'])
    assert_equal subnet, host.primary_interface.subnet
  end

  test "should setup subnet with org and loc" do
    org = FactoryGirl.create(:organization, :name => "subnet_org")
    loc = FactoryGirl.create(:location, :name => "subnet_loc")
    Setting['discovery_organization'] = org.name
    Setting['discovery_location'] = loc.name
    raw = parse_json_fixture('/facts.json')
    subnet = FactoryGirl.create(:subnet_ipv4, :name => 'Subnet99', :network => '10.35.27.0', :organizations => [org], :locations => [loc])
    Subnet.expects(:subnet_for).with('10.35.27.3').returns(subnet)
    host = Host::Discovered.import_host(raw['facts'])
    assert_equal subnet, host.primary_interface.subnet
  end

  test "should set nested org and loc" do
    org_parent = FactoryGirl.create(:organization, :name => "org")
    org = FactoryGirl.create(:organization, :name => "suborg", :parent_id => org_parent.id)
    loc_parent = FactoryGirl.create(:location, :name => "loc")
    loc = FactoryGirl.create(:location, :name => "subloc", :parent_id => loc_parent.id)
    Setting['discovery_organization'] = org.name
    Setting['discovery_location'] = loc.name
    raw = parse_json_fixture('/facts.json')
    subnet = FactoryGirl.create(:subnet_ipv4, :name => 'Subnet99', :network => '10.35.27.0', :organizations => [org], :locations => [loc])
    Subnet.expects(:subnet_for).with('10.35.27.3').returns(subnet)
    host = Host::Discovered.import_host(raw['facts'])
    assert_equal org, host.organization
    assert_equal loc, host.location
  end

  test "should raise when fact_name setting isn't present" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_fact] = 'macaddress_foo'
    exception = assert_raises(::Foreman::Exception) do
      Host::Discovered.import_host(raw['facts'])
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
    host = Host::Discovered.import_host(facts)
    assert_equal 'macsomename', host.name
    refute_equal 'e4:1f:13:cc:36:5a', host.mac
  end

  test "should lock host into discovery via PXE configuration" do
    Host::Discovered.delete('mace41f13cc3658')
    Setting[:discovery_lock] = "true"
    raw = parse_json_fixture('/facts.json')
    subnet = FactoryGirl.create(:subnet,
                                :tftp,
                                :network => '10.35.27.0',
                                :cidr    => '24',
                                :mask    => '255.255.255.0',
                                :organizations => [organization_one],
                                :locations => [location_one]
    )
    Subnet.expects(:subnet_for).with('10.35.27.3').returns(subnet)
    ProxyAPI::TFTP.any_instance.expects(:set).with(anything, 'e4:1f:13:cc:36:58', anything).returns(true).times(3)
    TemplateKind::PXE.each do |kind|
      ProvisioningTemplate.where(:name => "#{kind.downcase}_discovery").first_or_create(
          :template_kind_id => template_kinds(kind.downcase.to_sym),
          :snippet => true,
          :template => "test"
      )
    end
    assert Host::Discovered.import_host(raw['facts'])
    assert Host::Discovered.find_by_name('mace41f13cc3658')
    refute Host::Managed.find_by_name('mace41f13cc3658')
  end

  test "should create discovered host with fact_name as a name if it is a valid mac" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_fact] = 'somefact'
    Setting[:discovery_hostname] = 'somefact'
    facts = raw['facts'].merge({"somefact" => "E4:1F:13:CC:36:5A"})
    host = Host::Discovered.import_host(facts)
    assert_equal 'mace41f13cc365a', host.name
    assert_equal 'e4:1f:13:cc:36:5a', host.mac
  end

  test "should create discovered host with default name if fact_name isn't a valid mac" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_fact] = 'lsbdistcodename'
    exception = assert_raises(::Foreman::Exception) do
      Host::Discovered.import_host(raw['facts'])
    end
    assert_match(/Unable to detect primary interface using MAC/, exception.message)
  end

  test "should not create discovered host when managed host exists" do
    FactoryGirl.create(:host, :mac => 'E4:1F:13:CC:36:58')
    raw = parse_json_fixture('/facts.json')
    exception = assert_raises(::Foreman::Exception) do
      Host::Discovered.import_host(raw['facts'])
    end
    assert_match(/Host already exists as managed/, exception.message)
  end

  test "should create discovered host with prefix" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_prefix] = 'test'
    host = Host::Discovered.import_host(raw['facts'])
    assert_equal 'teste41f13cc3658', host.name
  end

  test "should create discovered host without prefix" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_prefix] = ''
    host = Host::Discovered.import_host(raw['facts'])
    assert_equal 'e41f13cc3658',host.name
  end

  test "should refresh existing discovered" do
    raw = parse_json_fixture('/facts.json')
    interface = mock()
    interface.stubs(:host).returns(Host.create(:name => "xyz", :type => "Host::Discovered"))
    ::Nic::Managed.stubs(:where).with(:mac => raw['facts']['discovery_bootif'].downcase, :primary => true).returns([interface])
    host = Host::Discovered.import_host(raw['facts'])
    assert_equal 'xyz', host.name
  end

  test "should raise when hostname fact cannot be found" do
    raw = parse_json_fixture('/facts.json')
    Setting[:discovery_hostname] = 'macaddress_foo'
    exception = assert_raises(::Foreman::Exception) do
      Host::Discovered.import_host(raw['facts'])
    end
    assert_match(/Invalid facts: hash does not contain a valid value for any of the facts in the discovery_hostname setting:/, exception.message)
  end

  test "should raise when hostname cannot be computed due to normlization and no prefix" do
    raw = parse_json_fixture('/facts.json')
    raw['facts']['invalidhostnamefact'] = '...'
    Setting[:discovery_hostname] = 'invalidhostnamefact'
    Setting[:discovery_prefix] = ''
    exception = assert_raises(::Foreman::Exception) do
      Host::Discovered.import_host(raw['facts'])
    end
    assert_match(/Invalid hostname: Could not normalize the hostname/, exception.message)
  end

  test 'discovered host can be searched in multiple taxonomies' do
    org1 = FactoryGirl.create(:organization)
    org2 = FactoryGirl.create(:organization)
    org3 = FactoryGirl.create(:organization)
    user_subset = FactoryGirl.create(:user, :organizations => [org1, org2])
    user_all = FactoryGirl.create(:user, :organizations => [org1, org2, org3])
    host1 = FactoryGirl.create(:host, :type => "Host::Discovered", :organization => org1)
    host2 = FactoryGirl.create(:host, :type => "Host::Discovered", :organization => org2)
    host3 = FactoryGirl.create(:host, :type => "Host::Discovered", :organization => org3)
    hosts = nil

    assert_nil Organization.current
    as_user(user_subset) do
      hosts = Host::Discovered.all
    end
    assert_includes hosts, host1
    assert_includes hosts, host2
    refute_includes hosts, host3

    as_user(user_all) do
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
    host = Host::Discovered.import_host(raw['facts'])
    host.save
    h = ::ForemanDiscovery::HostConverter.to_managed(host)
    refute_valid h
    assert Token.where(:host_id => h.id).empty?
  end

  test "all non-discovery facts are deleted after provisioning" do
    Setting[:discovery_clean_facts] = true
    raw = parse_json_fixture('/facts.json')['facts']
    raw.merge!({
      'delete_me' => "content",
      'discovery_keep_me' => "content",
      })
    host = Host::Discovered.import_host(raw)
    host.save
    managed = ::ForemanDiscovery::HostConverter.to_managed(host)
    managed.clear_facts
    assert_nil managed.facts_hash['delete_me']
    assert_equal "content", managed.facts_hash['discovery_keep_me']
  end

  test "all facts are preserved after provisioning" do
    raw = parse_json_fixture('/facts.json')['facts']
    raw.merge!({
      'keep_me' => "content",
      'discovery_keep_me' => "content",
      })
    host = Host::Discovered.import_host(raw)
    host.save
    managed = ::ForemanDiscovery::HostConverter.to_managed(host)
    managed.clear_facts
    assert_equal "content", managed.facts_hash['keep_me']
    assert_equal "content", managed.facts_hash['discovery_keep_me']
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
