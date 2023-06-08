require_relative '../test_plugin_helper'

class HostDiscoveredTest < ActiveSupport::TestCase
  include FactImporterIsolation
  allow_transactions_for_any_importer

  setup do
    @facts = parse_json_fixture('regular_host', true)
    set_default_settings
    ::ForemanDiscovery::HostConverter.stubs(:unused_ip_for_host)
  end

  test "should be able to create Host::Discovered objects" do
    host = Host.create :name => "mydiscoveredhost", :type => "Host::Discovered"

    assert host.is_a?(Host::Discovered)
  end

  test "should import facts from yaml as Host::Discovered" do
    assert discover_host_from_facts(@facts)
    assert Host::Discovered.find_by_name('mace41f13cc3658')
  end

  test "should import facts from yaml with MAC-based generator as Host::Discovered" do
    Setting[:discovery_naming] = "MAC-name"
    host = discover_host_from_facts(@facts)

    assert_equal "myrna-katie-wesly-maslyn", host.name
  end

  test "should import facts from yaml with random based generator as Host::Discovered" do
    Setting[:discovery_naming] = "Random-name"
    NameGenerator.any_instance.stubs(:register).returns(1305)
    host = discover_host_from_facts(@facts)

    assert_equal "velma-startin", host.name
  end

  test 'fact value association is set accordingly' do
    discovered_host = FactoryBot.create(:discovered_host, :with_facts, :fact_count => 1)
    fact_value = discovered_host.fact_values.first

    assert_equal discovered_host.id, fact_value.host.id
  end

  test "should detect bridge as the primary" do
    # Detected primary should be the bridge (.2)
    # "ipaddress_br180": "10.35.27.2"
    # "ipaddress_eth0": "10.35.27.3"
    # "ipaddress": "10.35.27.2"
    subnet = FactoryBot.create(:subnet_ipv4, :name => 'Subnet99', :network => '10.35.27.0', :organizations => [organization_one], :locations => [location_one])
    Subnet.expects(:subnet_for).with('10.35.27.2').returns(subnet)
    host = discover_host_from_facts(@facts)

    assert_equal '10.35.27.2', host.primary_interface.ip
  end

  test "should setup subnet" do
    subnet = FactoryBot.create(:subnet_ipv4, :name => 'Subnet99', :network => '10.35.27.0', :organizations => [organization_one], :locations => [location_one])
    Subnet.expects(:subnet_for).with('10.35.27.2').returns(subnet)
    host = discover_host_from_facts(@facts)

    assert_equal subnet, host.primary_interface.subnet
  end

  test "should setup subnet when update_subnets_from_facts is true" do
    Setting[:update_subnets_from_facts] = true
    subnet = FactoryBot.create(:subnet_ipv4, :name => 'Subnet99', :network => '10.35.27.0', :organizations => [organization_one], :locations => [location_one])
    Subnet.expects(:subnet_for).with('10.35.27.2').returns(subnet)
    host = discover_host_from_facts(@facts)

    assert_equal subnet, host.primary_interface.subnet
  end

  test "should setup subnet with org and loc set via settings" do
    org = FactoryBot.create(:organization, :name => "subnet_org")
    loc = FactoryBot.create(:location, :name => "subnet_loc")
    Setting['discovery_organization'] = org.name
    Setting['discovery_location'] = loc.name
    subnet = FactoryBot.create(:subnet_ipv4, :name => 'Subnet99', :network => '10.35.27.0', :organizations => [org], :locations => [loc])
    Subnet.expects(:subnet_for).with('10.35.27.2').returns(subnet)
    host = discover_host_from_facts(@facts)

    assert_equal subnet, host.primary_interface.subnet
    assert_equal org, host.organization
    assert_equal loc, host.location
  end

  test "should detect taxonomy as 'first' organization (e.g. randomly)" do
    org = FactoryBot.create(:organization)
    loc = FactoryBot.create(:location)
    org2 = FactoryBot.create(:organization)
    loc2 = FactoryBot.create(:location)
    Setting['discovery_organization'] = nil
    Setting['discovery_location'] = nil
    subnet = FactoryBot.create(:subnet_ipv4, :name => 'Subnet99', :network => '10.35.27.0', :organizations => [org, org2], :locations => [loc, loc2])
    Subnet.expects(:subnet_for).with('10.35.27.2').returns(subnet)
    host = discover_host_from_facts(@facts)

    assert_equal subnet, host.primary_interface.subnet
    assert host.organization
    assert host.location
  end

  test "discovery_organization must not be overriden by organization_fact from core" do
    begin
      org = FactoryBot.create(:organization, :name => "subnet_org", :title => "subnet_org")
      loc = FactoryBot.create(:location, :name => "subnet_loc", :title => "subnet_loc")
      bad_org = FactoryBot.create(:organization, :name => "bad_org", :title => "bad_org")
      bad_loc = FactoryBot.create(:location, :name => "bad_loc", :title => "bad_loc")
      Setting['organization_fact'] = "test_org"
      Setting['location_fact'] = "test_loc"
      Setting['discovery_organization'] = org.name
      Setting['discovery_location'] = loc.name
      subnet = FactoryBot.create(:subnet_ipv4, :name => 'Subnet99', :network => '10.35.27.0', :organizations => [org], :locations => [loc])
      Subnet.expects(:subnet_for).with('10.35.27.2').returns(subnet)
      host = discover_host_from_facts(@facts.merge("test_org" => bad_org.title, "test_loc" => bad_loc.title))

      assert_equal subnet, host.primary_interface.subnet
      assert_equal org, host.organization
      assert_equal loc, host.location
    ensure
      Setting['organization_fact'] = nil
      Setting['location_fact'] = nil
    end
  end

  test "discovery_organization must not be overriden by foreman_organization from core" do
    org = FactoryBot.create(:organization, :name => "subnet_org", :title => "subnet_org")
    loc = FactoryBot.create(:location, :name => "subnet_loc", :title => "subnet_loc")
    bad_org = FactoryBot.create(:organization, :name => "bad_org", :title => "bad_org")
    bad_loc = FactoryBot.create(:location, :name => "bad_loc", :title => "bad_loc")
    Setting['discovery_organization'] = org.name
    Setting['discovery_location'] = loc.name
    subnet = FactoryBot.create(:subnet_ipv4, :name => 'Subnet99', :network => '10.35.27.0', :organizations => [org, bad_org], :locations => [loc, bad_loc])
    Subnet.expects(:subnet_for).with('10.35.27.2').returns(subnet)
    host = discover_host_from_facts(@facts.merge("foreman_organization" => bad_org.title, "foreman_location" => bad_loc.title))

    assert_equal subnet, host.primary_interface.subnet
    assert_equal org, host.organization
    assert_equal loc, host.location
  end

  test "discovery_organization must not be overriden by default_organization from core" do
    begin
      org = FactoryBot.create(:organization, :name => "subnet_org", :title => "subnet_org")
      loc = FactoryBot.create(:location, :name => "subnet_loc", :title => "subnet_loc")
      bad_org = FactoryBot.create(:organization, :name => "bad_org", :title => "bad_org")
      bad_loc = FactoryBot.create(:location, :name => "bad_loc", :title => "bad_loc")
      Setting['default_organization'] = bad_org.title
      Setting['default_location'] = bad_loc.title
      Setting['discovery_organization'] = org.name
      Setting['discovery_location'] = loc.name
      subnet = FactoryBot.create(:subnet_ipv4, :name => 'Subnet99', :network => '10.35.27.0', :organizations => [org, bad_org], :locations => [loc, bad_loc])
      Subnet.expects(:subnet_for).with('10.35.27.2').returns(subnet)
      host = discover_host_from_facts(@facts)

      assert_equal subnet, host.primary_interface.subnet
      assert_equal org, host.organization
      assert_equal loc, host.location
    ensure
      Setting['default_organization'] = nil
      Setting['default_location'] = nil
    end
  end

  test "should set nested org and loc" do
    org_parent = FactoryBot.create(:organization, :name => "org")
    org = FactoryBot.create(:organization, :name => "suborg", :parent_id => org_parent.id)
    loc_parent = FactoryBot.create(:location, :name => "loc")
    loc = FactoryBot.create(:location, :name => "subloc", :parent_id => loc_parent.id)
    Setting['discovery_organization'] = org.name
    Setting['discovery_location'] = loc.name
    subnet = FactoryBot.create(:subnet_ipv4, :name => 'Subnet99', :network => '10.35.27.0', :organizations => [org], :locations => [loc])
    Subnet.expects(:subnet_for).with('10.35.27.2').returns(subnet)
    host = discover_host_from_facts(@facts)

    assert_equal org, host.organization
    assert_equal loc, host.location
  end

  test "should raise when fact_name setting isn't present" do
    Setting[:discovery_fact] = 'macaddress_foo'
    exception = assert_raises(::Foreman::Exception) do
      discover_host_from_facts(@facts)
    end

    assert_match(/Expected discovery_fact '\w+' is missing/, exception.message)
  end

  test "should be able to refresh facts" do
    host = Host.create :name => "mydiscoveredhost", :ip => "1.2.3.4", :type => "Host::Discovered"
    ::ForemanDiscovery::NodeAPI::Inventory.any_instance.stubs(:facter).returns(@facts)

    assert host.refresh_facts
  end

  test "should create discovered host with hostname if a fact was supplied" do
    Setting[:discovery_hostname] = ['somefact']
    facts = @facts.merge({"somefact" => "somename"})
    host = discover_host_from_facts(facts)

    assert_equal 'macsomename', host.name
    refute_equal 'e4:1f:13:cc:36:5a', host.mac
  end

  test "should lock host into discovery via PXE configuration" do
    begin
      Host::Discovered.delete('mace41f13cc3658')
      Setting[:discovery_lock] = true
      subnet = FactoryBot.create(:subnet,
                                  :tftp,
                                  :network => '10.35.27.0',
                                  :cidr    => '24',
                                  :mask    => '255.255.255.0',
                                  :organizations => [organization_one],
                                  :locations => [location_one]
      )
      Subnet.expects(:subnet_for).with('10.35.27.2').returns(subnet)
      ProxyAPI::TFTP.any_instance.expects(:set).with(anything, 'e4:1f:13:cc:36:58', anything).returns(true).times(3)
      TemplateKind::PXE.each do |kind|
        ProvisioningTemplate.where(:name => "#{kind.downcase}_discovery").first_or_create(
            :template_kind_id => template_kinds(kind.downcase.to_sym),
            :snippet => true,
            :template => "test"
        )
      end

      assert discover_host_from_facts(@facts)
      assert Host::Discovered.find_by_name('mace41f13cc3658')
      refute Host::Managed.find_by_name('mace41f13cc3658')
    ensure
      Setting[:discovery_lock] = false
    end
  end

  test "should create discovered host with fact_name as a name if it is a valid mac" do
    Setting[:discovery_fact] = 'somefact'
    Setting[:discovery_hostname] = ['somefact']
    facts = @facts.merge({"somefact" => "E4:1F:13:CC:36:5A"})
    host = discover_host_from_facts(facts)

    assert_equal 'mace41f13cc365a', host.name
    assert_equal 'e4:1f:13:cc:36:5a', host.mac
  end

  test "should create discovered host with default name if fact_name isn't a valid mac" do
    Setting[:discovery_fact] = 'lsbdistcodename'
    exception = assert_raises(::Foreman::Exception) do
      discover_host_from_facts(@facts)
    end

    assert_match(/Unable to find primary NIC/, exception.message)
  end

  test "should not create discovered host when managed host exists" do
    begin
      Setting[:discovery_error_on_existing] = true
      FactoryBot.create(:host, :mac => 'E4:1F:13:CC:36:58')
      exception = assert_raises(::Foreman::Exception) do
        discover_host_from_facts(@facts)
      end

      assert_match(/One or more existing managed hosts found/, exception.message)
    ensure
      Setting[:discovery_error_on_existing] = false
    end
  end

  test "should allow existing managed host discovery" do
    FactoryBot.create(:host, :mac => 'E4:1F:13:CC:36:58')
    host = discover_host_from_facts(@facts)

    assert_equal 'mace41f13cc3658', host.name
    assert_equal 'e4:1f:13:cc:36:58', host.mac
  end

  test "should create discovered host with prefix" do
    Setting[:discovery_prefix] = 'test'
    host = discover_host_from_facts(@facts)

    assert_equal 'teste41f13cc3658', host.name
  end

  test "should refresh facts and NICs of an existing discovered host" do
    host1 = discover_host_from_facts(@facts)

    assert_equal 'mace41f13cc3658', host1.name
    assert_equal 'IBM System x -[7870K4G]-', host1.facts["productname"]
    assert_equal 1, Host::Discovered.where(:name => 'mace41f13cc3658').count
    assert_equal '10.35.27.2', host1.ip

    @facts["ipaddress_eth0"] = "1.2.3.4"
    @facts["productname"] = "Dishwasher DW400"
    host2 = discover_host_from_facts(@facts)

    assert_equal 'mace41f13cc3658', host2.name
    assert_equal 'Dishwasher DW400', host2.facts["productname"]
    assert_equal '10.35.27.2', host2.ip
    assert_equal 1, Host::Discovered.where(:name => 'mace41f13cc3658').count
  end

  test "should raise when hostname fact cannot be found" do
    Setting[:discovery_hostname] = ['macaddress_foo']
    exception = assert_raises(::Foreman::Exception) do
      discover_host_from_facts(@facts)
    end

    assert_match(/Invalid facts: hash does not contain a valid value for any of the facts in the discovery_hostname setting:/, exception.message)
  end

  test 'discovered host can be searched in multiple taxonomies' do
    org1 = FactoryBot.create(:organization)
    org2 = FactoryBot.create(:organization)
    org3 = FactoryBot.create(:organization)
    user_subset = FactoryBot.create(:user, :organizations => [org1, org2])
    user_all = FactoryBot.create(:user, :organizations => [org1, org2, org3])
    host1 = FactoryBot.create(:host, :type => "Host::Discovered", :organization => org1)
    host2 = FactoryBot.create(:host, :type => "Host::Discovered", :organization => org2)
    host3 = FactoryBot.create(:host, :type => "Host::Discovered", :organization => org3)

    assert_nil Organization.current

    hosts = as_user(user_subset) { Host::Discovered.all }.map(&:name)

    assert_includes hosts, host1.name
    assert_includes hosts, host2.name
    refute_includes hosts, host3.name

    hosts = as_user(user_all) { Host::Discovered.all }.map(&:name)

    assert_includes hosts, host1.name
    assert_includes hosts, host2.name
    assert_includes hosts, host3.name
  end

  test "provisioning a discovered host without saving it doesn't create a token" do
    Setting[:token_duration] = 30 #enable tokens so that we only test the CR
    Setting[:discovery_prefix] = '123'
    host = discover_host_from_facts(@facts)
    host.save
    h = ::ForemanDiscovery::HostConverter.to_managed(host)

    refute_valid h
    assert_predicate Token.where(:host_id => h.id), :empty?
  end

  test "all non-discovery facts are deleted after managed conversion" do
    Setting[:discovery_clean_facts] = true
    raw = parse_json_fixture('regular_host', true)
    raw.merge!({
      'delete_me' => "content",
      'discovery_keep_me' => "content",
      })
    host = discover_host_from_facts(raw)
    host.save
    managed = ::ForemanDiscovery::HostConverter.to_managed(host)
    managed.clear_facts

    assert_nil managed.facts_hash['delete_me']
    assert_equal "content", managed.facts_hash['discovery_keep_me']
  end

  test "primary interface is preserved after managed conversion" do
    raw = parse_json_fixture('regular_host', true)
    raw.merge!({
      'keep_me' => "content",
      'discovery_keep_me' => "content",
      })
    host = discover_host_from_facts(raw)
    host.save
    managed = ::ForemanDiscovery::HostConverter.to_managed(host)

    refute_nil managed.primary_interface
    assert_equal "e4:1f:13:cc:36:58", managed.primary_interface.mac
  end

  test "provision interface is preserved after managed conversion" do
    raw = parse_json_fixture('regular_host', true)
    raw.merge!({
      'keep_me' => "content",
      'discovery_keep_me' => "content",
      })
    host = discover_host_from_facts(raw)
    host.save
    managed = ::ForemanDiscovery::HostConverter.to_managed(host)

    refute_nil managed.provision_interface
    assert_equal "e4:1f:13:cc:36:58", managed.provision_interface.mac
  end

  test "provision interface host association is preserved after managed conversion" do
    raw = parse_json_fixture('regular_host', true)
    raw.merge!({
      'keep_me' => "content",
      'discovery_keep_me' => "content",
      })
    host = discover_host_from_facts(raw)
    host.save
    managed = ::ForemanDiscovery::HostConverter.to_managed(host)

    refute_nil managed.provision_interface
    assert_equal host, managed.provision_interface.host
  end

  test "all facts are preserved after managed conversion" do
    raw = parse_json_fixture('regular_host', true)
    raw.merge!({
      'keep_me' => "content",
      'discovery_keep_me' => "content",
      })
    host = discover_host_from_facts(raw)
    host.save
    managed = ::ForemanDiscovery::HostConverter.to_managed(host)
    managed.clear_facts

    assert_equal "content", managed.facts_hash['keep_me']
    assert_equal "content", managed.facts_hash['discovery_keep_me']
  end

  test "normalization of MAC into a discovered host hostname" do
    assert_equal("90b11c54d582", Host::Discovered.normalize_string_for_hostname("90:B1:1C:54:D5:82"))
  end

  test "normalization of a string containing multiple non-alphabetical characters" do
    assert_equal("testhostname", Host::Discovered.normalize_string_for_hostname(".-_Test::Host.name_-."))
  end

  test "normalization of a valid hostname" do
    assert_equal("testhostname", Host::Discovered.normalize_string_for_hostname("testhostname"))
  end

  test "empty string after hostname normalization should raise an error" do
    exception = assert_raises(::Foreman::Exception) do
      Host::Discovered.normalize_string_for_hostname(".-_")
    end

    assert_match(/Invalid hostname: Could not normalize the hostname/, exception.message)
  end

  test "choosing the first valid fact from array of fact names" do
    facts = {"custom_hostname" => "testhostname","notmyfact" => "notusedfactvalue"}
    discovery_hostname_fact_array = ['macaddress','custom_hostname','someotherfact']

    assert_equal("testhostname", Host::Discovered.return_first_valid_fact(discovery_hostname_fact_array,facts))
  end

  test "choosing the first valid MAC address from array of fact names" do
    facts = {"custom_hostname" => "testhostname","macaddress" => "e5:17:4e:28:02:4c","notmyfact" => "notusedfactvalue"}
    discovery_hostname_fact_array = ['custom_hostname','macaddress','someotherfact']

    assert_equal("e5:17:4e:28:02:4c", Host::Discovered.return_first_valid_mac(discovery_hostname_fact_array,facts))
  end

  context 'notification recipients' do
    setup do
      @admins = User.except_hidden.where(:admin => true).pluck(:id)
      @org = FactoryBot.create(:organization)
      @host = FactoryBot.create(:discovered_host)
    end

    test 'finds admin users' do
      assert_equal @admins.sort, @host.notification_recipients_ids.sort
    end

    test 'finds users who can create_host in the host org' do
      setup_user 'create', 'hosts'
      User.current.organizations << @org
      recipients = [User.current.id, @admins].flatten.sort
      @host.organization = @org

      assert_equal recipients, @host.notification_recipients_ids.sort
    end
  end

  test "primary interface via tagged VLAN is discovered with an IP" do
    raw = parse_json_fixture('rhel7-vlan')
    host = discover_host_from_facts(raw)

    assert_equal "192.168.1.16", host.ip
    assert_equal "eno49.444", host.primary_interface.identifier
  end

  test "primary interface isn't touched with no LLDP facts" do
    Setting[:discovery_auto_bond] = true
    raw = parse_json_fixture('regular_host', true)
    host = discover_host_from_facts(raw)

    refute_nil host.primary_interface
    assert_equal "br180", host.primary_interface.identifier
  end

  test "provision_interface isn't touched with no peer on the same VLAN" do
    Setting[:discovery_auto_bond] = true
    raw = parse_json_fixture('facts_with_lldp', true)
    host = discover_host_from_facts(raw)

    refute_nil host.primary_interface
    assert_equal "br180", host.primary_interface.identifier
  end

  test "provision_interface is switched to bond0 with more than one interface on the same VLAN" do
    Setting[:discovery_auto_bond] = true
    raw = parse_json_fixture('facts_with_lldp_bond_candidate', true)
    host = discover_host_from_facts(raw)

    refute_nil host.primary_interface
    assert_equal "bond0", host.primary_interface.identifier
  end

  test "provision_interface is not switched to bond0 if disabled" do
    Setting[:discovery_auto_bond] = false
    raw = parse_json_fixture('facts_with_lldp_bond_candidate', true)
    host = discover_host_from_facts(raw)

    refute_nil host.primary_interface
    assert_equal "eth0", host.primary_interface.identifier
  end

  test "former provision_interface is cleanup up after switching to bond0" do
    Setting[:discovery_auto_bond] = true
    raw = parse_json_fixture('facts_with_lldp_bond_candidate', true)
    host = discover_host_from_facts(raw)

    refute_nil host.primary_interface

    former_interface = nil
    host.interfaces.each do |interface|
      former_interface = interface if interface.identifier == 'eth0'
    end

    refute_nil former_interface
    assert_instance_of ::Nic::Managed, former_interface
    assert_nil former_interface.ip
    assert_nil former_interface.name
    assert_equal false, former_interface.primary
  end
end
