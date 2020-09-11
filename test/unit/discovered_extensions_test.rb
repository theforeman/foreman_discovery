require_relative '../test_plugin_helper'

class DiscoveredExtensionsTest < ActiveSupport::TestCase
  include Foreman::Controller::DiscoveredExtensions
  include FactImporterIsolation
  allow_transactions_for_any_importer

  setup do
    @facts = facts_simple_network100_42
    @facts_ipv6 = facts_network_2001_db8
    set_default_settings
    ProxyAPI::DHCP.any_instance.stubs(:record).returns(nil)
    ::ForemanDiscovery::HostConverter.stubs(:unused_ip_for_host)
  end

  test "no rule is found for empty rule set" do
    host = discover_host_from_facts(@facts)
    refute find_discovery_rule(host)
  end

  test "no rule is found out of one for a discovered host with no facts" do
    host = discover_host_from_facts(@facts)
    FactoryBot.create(:discovery_rule, :search => "facts.foo = bar")
    refute find_discovery_rule(host)
  end

  test "no rule is found out of one for a discovered host with some facts" do
    host = discover_host_from_facts(@facts)
    FactoryBot.create(:discovery_rule, :search => "facts.foo = doesnotexist")
    refute find_discovery_rule(host)
  end

  test "no rule is found out of two for a discovered host" do
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    FactoryBot.create(:discovery_rule, :priority => 1, :search => "facts.somefact = xxx")
    FactoryBot.create(:discovery_rule, :priority => 2, :search => "facts.somefact = zzz")
    refute find_discovery_rule(host)
  end

  test "rule out of one is found for a discovered host" do
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    r1 = FactoryBot.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc",
                            :organizations => [host.organization], :locations => [host.location])
    assert_equal find_discovery_rule(host), r1
  end

  test "first rule out of two is found for a discovered host" do
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    r1 = FactoryBot.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc",
                            :organizations => [host.organization], :locations => [host.location])
    FactoryBot.create(:discovery_rule, :priority => 0, :search => "facts.somefact = x",
                       :organizations => [host.organization], :locations => [host.location])
    assert_equal find_discovery_rule(host), r1
  end

  test "second rule out of two is found for a discovered host" do
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    FactoryBot.create(:discovery_rule, :priority => 0, :search => "facts.somefact = x",
                       :organizations => [host.organization], :locations => [host.location])
    r2 = FactoryBot.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc",
                            :organizations => [host.organization], :locations => [host.location])
    assert_equal find_discovery_rule(host), r2
  end

  test "first rule out of two with different priorities is found for a discovered host" do
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    r1 = FactoryBot.create(:discovery_rule, :name => "A", :priority => 1, :search => "facts.somefact = abc",
                            :organizations => [host.organization], :locations => [host.location])
    r2 = FactoryBot.create(:discovery_rule, :name => "B", :priority => 2, :search => "facts.somefact = abc",
                       :organizations => [host.organization], :locations => [host.location])
    assert_equal find_discovery_rule(host), r1
  end

  test "second rule out of two with different priorities is found for a discovered host" do
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    r1 = FactoryBot.create(:discovery_rule, :name => "A", :priority => 2, :search => "facts.somefact = abc",
                       :organizations => [host.organization], :locations => [host.location])
    r2 = FactoryBot.create(:discovery_rule, :name => "B", :priority => 1, :search => "facts.somefact = abc",
                            :organizations => [host.organization], :locations => [host.location])
    assert_equal find_discovery_rule(host), r2
  end

  test "drained rule does not match for a discovered host" do
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    r1 = FactoryBot.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc", :max_count => 1,
                            :organizations => [host.organization], :locations => [host.location])
    r2 = FactoryBot.create(:discovery_rule, :priority => 2, :search => "facts.somefact = abc",
                            :organizations => [host.organization], :locations => [host.location])
    FactoryBot.create(:host, :discovery_rule => r1)
    assert_equal find_discovery_rule(host), r2
  end

  test "discovery rule is associated after auto provisioning" do
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    r1 = FactoryBot.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc",
                            :organizations => [host.organization], :locations => [host.location])
    perform_auto_provision host, r1
    assert_equal host.primary_interface.managed, true
    assert_equal host.build, true
    assert_equal host.hostgroup_id, r1.hostgroup_id
    assert_equal host.discovery_rule_id, r1.id
  end

  test "auto provisioning fails for rule without a hostgroup" do
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    r1 = FactoryBot.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc",
                            :organizations => [host.organization], :locations => [host.location])
    r1.hostgroup = nil
    exception = assert_raises(::Foreman::Exception) do
      perform_auto_provision host, r1
    end
    assert_match /No hostgroup associated with rule/, exception.message
  end

  test "existing rule revent from hostgroup deletion" do
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    r1 = FactoryBot.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc",
                            :organizations => [host.organization], :locations => [host.location])
    assert_raises(ActiveRecord::RecordNotDestroyed) do
      r1.hostgroup.destroy!
    end
  end

  test "rules with incorrect syntax are skipped" do
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    FactoryBot.create(:discovery_rule, :priority => 1, :search => '=!^$#@?x',
                       :organizations => [host.organization], :locations => [host.location])
    r2 = FactoryBot.create(:discovery_rule, :priority => 2, :search => "facts.somefact = abc",
                            :organizations => [host.organization], :locations => [host.location])
    assert_equal find_discovery_rule(host), r2
  end

  test "hostname is copied after auto provisioning" do
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    r1 = FactoryBot.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc",
                            :organizations => [host.organization], :locations => [host.location])
    perform_auto_provision host, r1
    assert_equal host.name, "macaabbccddeeff"
  end

  test "attributes from hostgroup are copied after auto provisioning for host with subnet detected" do
    facts = @facts.merge({"somefact" => "abc"})
    domain = FactoryBot.create(:domain)
    subnet = FactoryBot.create(:subnet_ipv4, :tftp, :dhcp, :name => 'subnet_100', :network => '192.168.100.0', :organizations => [Organization.find_by_name("Organization 1")], :locations => [Location.find_by_name("Location 1")])
    host = discover_host_from_facts(facts)
    assert_equal subnet, host.subnet
    hostgroup = FactoryBot.create(:hostgroup, :with_environment, :with_rootpass, :with_puppet_orchestration, :with_os, :pxe_loader => "PXELinux BIOS", :subnet => subnet, :domain => domain)
    r1 = FactoryBot.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc", :organizations => [host.organization], :locations => [host.location], :hostgroup => hostgroup)
    host.primary_interface.expects(:queue_tftp).at_least(1)
    host.primary_interface.expects(:queue_dhcp).at_least(1)
    managed_host = perform_auto_provision(host, r1)
    assert_empty host.errors
    assert managed_host
    assert_empty managed_host.errors
    refute_nil hostgroup.pxe_loader, managed_host.pxe_loader
    assert_equal hostgroup.pxe_loader, managed_host.pxe_loader
    refute_nil hostgroup.subnet, managed_host.subnet
    assert_equal hostgroup.subnet, managed_host.subnet
    refute_nil hostgroup.subnet, managed_host.primary_interface.subnet
    assert_equal hostgroup.subnet, managed_host.primary_interface.subnet
    refute_nil hostgroup.subnet, managed_host.provision_interface.subnet
    assert_equal hostgroup.subnet, managed_host.provision_interface.subnet
    refute_nil hostgroup.domain, managed_host.domain
    assert_equal hostgroup.domain, managed_host.domain
    refute_nil hostgroup.environment, managed_host.environment
    assert_equal hostgroup.environment, managed_host.environment
    refute_nil hostgroup.puppet_proxy, managed_host.puppet_proxy
    assert_equal hostgroup.puppet_proxy, managed_host.puppet_proxy
    refute_nil hostgroup.puppet_ca_proxy, managed_host.puppet_ca_proxy
    assert_equal hostgroup.puppet_ca_proxy, managed_host.puppet_ca_proxy
  end

  class StubIPAM
    def suggest_ip
      "192.168.101.13"
    end
  end

  test "subnet is changed and unused_ip called" do
    ::ForemanDiscovery::HostConverter.unstub(:unused_ip_for_host)
    facts = @facts.merge({"somefact" => "abc"})
    domain = FactoryBot.create(:domain)
    subnet = FactoryBot.create(:subnet_ipv4, :tftp, :dhcp, :name => 'subnet_100', :network => '192.168.100.0', :organizations => [Organization.find_by_name("Organization 1")], :locations => [Location.find_by_name("Location 1")])
    subnet2 = FactoryBot.create(:subnet_ipv4, :tftp, :dhcp, :name => 'subnet_101', :network => '192.168.101.0', :organizations => [Organization.find_by_name("Organization 1")], :locations => [Location.find_by_name("Location 1")])
    host = discover_host_from_facts(facts)
    assert_equal subnet, host.subnet
    hostgroup = FactoryBot.create(:hostgroup, :with_environment, :with_rootpass, :with_puppet_orchestration, :with_os, :pxe_loader => "PXELinux BIOS", :subnet => subnet2, :domain => domain)
    r1 = FactoryBot.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc", :organizations => [host.organization], :locations => [host.location], :hostgroup => hostgroup)
    Subnet.any_instance.expects(:unused_ip).with(host.mac).returns(StubIPAM.new)
    host.primary_interface.stubs(:queue_tftp)
    host.primary_interface.stubs(:queue_dhcp)
    managed_host = perform_auto_provision(host, r1)
    assert_empty host.errors
    assert managed_host
    assert_empty managed_host.errors
    refute_nil hostgroup.subnet
    refute_nil managed_host.subnet
    assert_equal hostgroup.subnet, managed_host.subnet
    assert_equal "192.168.101.13", managed_host.ip
  end

  test "subnet6 is changed and unused_ip called" do
    ::ForemanDiscovery::HostConverter.unstub(:unused_ip_for_host)
    facts = @facts_ipv6.merge({"somefact" => "abc"})
    domain = FactoryBot.create(:domain)
    subnet = FactoryBot.create(:subnet_ipv6, :tftp, :dhcp, :network => "2001:db8::/32", :mask => "ffff:ffff::", :name => "ipv6_discovered", :ipam => IPAM::MODES[:eui64], :organizations => [Organization.find_by_name("Organization 1")], :locations => [Location.find_by_name("Location 1")])
    subnet2 = FactoryBot.create(:subnet_ipv6, :tftp, :dhcp, :network => "2001:db9::/32", :mask => "ffff:ffff::", :name => "ipv6_provision", :ipam => IPAM::MODES[:eui64], :organizations => [Organization.find_by_name("Organization 1")], :locations => [Location.find_by_name("Location 1")])
    host = discover_host_from_facts(facts)
    assert_equal subnet, host.subnet6
    hostgroup = FactoryBot.create(:hostgroup, :with_environment, :with_rootpass, :with_puppet_orchestration, :with_os, :pxe_loader => "PXELinux BIOS", :subnet6 => subnet2, :domain => domain)
    r1 = FactoryBot.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc", :organizations => [host.organization], :locations => [host.location], :hostgroup => hostgroup)
    host.primary_interface.stubs(:queue_tftp)
    host.primary_interface.stubs(:queue_dhcp)
    managed_host = perform_auto_provision(host, r1)
    assert_empty host.errors
    assert managed_host
    assert_empty managed_host.errors
    refute_nil hostgroup.subnet6
    refute_nil managed_host.subnet6
    assert_equal hostgroup.subnet6, managed_host.subnet6
    assert_equal "2001:db9::a8bb:ccff:fedd:eefa", managed_host.ip6
  end

  test "attributes from hostgroup are copied after auto provisioning for host without subnet detected" do
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    refute host.subnet
    domain = FactoryBot.create(:domain)
    subnet = FactoryBot.create(:subnet_ipv4, :tftp, :dhcp, :name => 'subnet_100', :network => '192.168.100.0', :organizations => [Organization.find_by_name("Organization 1")], :locations => [Location.find_by_name("Location 1")])
    hostgroup = FactoryBot.create(:hostgroup, :with_environment, :with_rootpass, :with_puppet_orchestration, :with_os, :pxe_loader => "PXELinux BIOS", :subnet => subnet, :domain => domain)
    r1 = FactoryBot.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc", :organizations => [host.organization], :locations => [host.location], :hostgroup => hostgroup)
    host.primary_interface.expects(:queue_tftp).at_least(1)
    host.primary_interface.expects(:queue_dhcp).at_least(1)
    managed_host = perform_auto_provision(host, r1)
    assert_empty host.errors
    assert managed_host
    assert_empty managed_host.errors
    refute_nil hostgroup.pxe_loader, managed_host.pxe_loader
    assert_equal hostgroup.pxe_loader, managed_host.pxe_loader
    refute_nil hostgroup.subnet, managed_host.subnet
    assert_equal hostgroup.subnet, managed_host.subnet
    refute_nil hostgroup.subnet, managed_host.primary_interface.subnet
    assert_equal hostgroup.subnet, managed_host.primary_interface.subnet
    refute_nil hostgroup.subnet, managed_host.provision_interface.subnet
    assert_equal hostgroup.subnet, managed_host.provision_interface.subnet
    refute_nil hostgroup.domain, managed_host.domain
    assert_equal hostgroup.domain, managed_host.domain
    refute_nil hostgroup.environment, managed_host.environment
    assert_equal hostgroup.environment, managed_host.environment
    refute_nil hostgroup.puppet_proxy, managed_host.puppet_proxy
    assert_equal hostgroup.puppet_proxy, managed_host.puppet_proxy
    refute_nil hostgroup.puppet_ca_proxy, managed_host.puppet_ca_proxy
    assert_equal hostgroup.puppet_ca_proxy, managed_host.puppet_ca_proxy
  end

  def setup_normal_renderer
    Setting[:safemode_render] = false
    @facts.merge!({"somefact" => "abc"})
  end

  def setup_safemode_renderer
    Setting[:safemode_render] = true
    @facts.merge!({"somefact" => "abc"})
  end

  [:normal_renderer, :safemode_renderer].each do |renderer_name|
    test "#{renderer_name} is properly configured" do
      send "setup_#{renderer_name}"
      if renderer_name == :normal_renderer
        assert Setting[:safemode_render] == false
      else
        assert Setting[:safemode_render] == true
      end
    end

    test "hostname falls back to original name on empty response via #{renderer_name}" do
      host = discover_host_from_facts(@facts)
      r1 = FactoryBot.create(:discovery_rule,
                              :search => "facts.somefact = abc",
                              :hostname => '<%= "" %>',
                              :organizations => [host.organization],
                              :locations => [host.location])
      refute perform_auto_provision host, r1
      assert_equal "macaabbccddeeff", host.name
    end

    test "hostname is rendered after auto provisioning using #{renderer_name}" do
      host = discover_host_from_facts(@facts)
      r1 = FactoryBot.create(:discovery_rule,
                              :search => "facts.somefact = abc",
                              :hostname => 'x<%= 1+1 %>',
                              :organizations => [host.organization],
                              :locations => [host.location])
      refute perform_auto_provision host, r1
      assert_equal "x2", host.name
    end

    test "function rand is renderer properly using #{renderer_name}" do
      host = discover_host_from_facts(@facts)
      r1 = FactoryBot.create(:discovery_rule,
                              :search => "facts.somefact = abc",
                              :hostname => 'x<%= rand(4) %>',
                              :organizations => [host.organization],
                              :locations => [host.location])
      refute perform_auto_provision host, r1
      assert_match(/x[0123]/, host.name)
    end

    test "hostname attribute name is renderer properly using #{renderer_name}" do
      host = discover_host_from_facts(@facts)
      r1 = FactoryBot.create(:discovery_rule,
                              :search => "facts.somefact = abc",
                              :hostname => 'x<%= @host.name %>',
                              :organizations => [host.organization],
                              :locations => [host.location])
      refute perform_auto_provision host, r1
      assert_equal "xmacaabbccddeeff", host.name
    end

    test "hostname attribute ip is renderer properly using #{renderer_name}" do
      host = discover_host_from_facts(@facts)
      r1 = FactoryBot.create(:discovery_rule,
                              :search => "facts.somefact = abc",
                              :hostname => 'x<%= @host.ip.gsub(".","-") %>',
                              :organizations => [host.organization],
                              :locations => [host.location])
      refute perform_auto_provision host, r1
      assert_equal "x192-168-100-42", host.name
    end

    test "hostname attribute facts_hash is renderer properly using #{renderer_name}" do
      facts = @facts.merge({"somefact" => "abc"})
      host = discover_host_from_facts(facts)
      r1 = FactoryBot.create(:discovery_rule,
                              :search => "facts.somefact = abc",
                              :hostname => 'x<%= @host.facts["somefact"] %>',
                              :organizations => [host.organization],
                              :locations => [host.location])
      refute perform_auto_provision host, r1
      assert_equal "xabc", host.name
    end
  end
end
