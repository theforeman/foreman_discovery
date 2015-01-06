require 'test_helper'

class FindDiscoveryRulesTest < ActiveSupport::TestCase
  include Foreman::Controller::DiscoveredExtensions

  setup do
    @facts = {
      "ipaddress" => "192.168.100.42",
      "macaddress" => "AA:BB:CC:DD:EE:FF",
      "discovery_bootif" => "AA:BB:CC:DD:EE:FF",
    }
  end

  test "no rule is found for empty rule set" do
    host = FactoryGirl.create(:host)
    refute find_discovery_rule(host)
  end

  test "no rule is found out of one for a discovered host with no facts" do
    host = FactoryGirl.create(:host)
    FactoryGirl.create(:discovery_rule, :search => "facts.foo = bar")
    refute find_discovery_rule(host)
  end

  test "no rule is found out of one for a discovered host with some facts" do
    host = FactoryGirl.create(:host, :with_facts)
    FactoryGirl.create(:discovery_rule, :search => "facts.foo = does not exist")
    refute find_discovery_rule(host)
  end

  test "no rule is found out of two for a discovered host" do
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host_and_facts(facts).first
    FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = xxx")
    FactoryGirl.create(:discovery_rule, :priority => 2, :search => "facts.somefact = zzz")
    refute find_discovery_rule(host)
  end

  test "rule out of one is found for a discovered host" do
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host_and_facts(facts).first
    r1 = FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc")
    assert_equal find_discovery_rule(host), r1
  end

  test "first rule out of two is found for a discovered host" do
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host_and_facts(facts).first
    r1 = FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc")
    FactoryGirl.create(:discovery_rule, :priority => 2, :search => "facts.somefact = abc")
    assert_equal find_discovery_rule(host), r1
  end

  test "second rule out of two is found for a discovered host" do
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host_and_facts(facts).first
    FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = x")
    r2 = FactoryGirl.create(:discovery_rule, :priority => 2, :search => "facts.somefact = abc")
    assert_equal find_discovery_rule(host), r2
  end

  test "drained rule does not match for a discovered host" do
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host_and_facts(facts).first
    r1 = FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc", :max_count => 1)
    r2 = FactoryGirl.create(:discovery_rule, :priority => 2, :search => "facts.somefact = abc")
    FactoryGirl.create(:host, :discovery_rule => r1)
    assert_equal find_discovery_rule(host), r2
  end

  test "discovery rule is associated after auto provisioning" do
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host_and_facts(facts).first
    r1 = FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc")
    perform_auto_provision host, r1
    assert_equal host.managed, true
    assert_equal host.build, true
    assert_equal host.hostgroup_id, r1.hostgroup_id
    assert_equal host.discovery_rule_id, r1.id
  end

  test "rules with incorrect syntax are skipped" do
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host_and_facts(facts).first
    FactoryGirl.create(:discovery_rule, :priority => 1, :search => '=!^$#@?x')
    r2 = FactoryGirl.create(:discovery_rule, :priority => 2, :search => "facts.somefact = abc")
    assert_equal find_discovery_rule(host), r2
  end

  test "hostname is copied after auto provisioning" do
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host_and_facts(facts).first
    r1 = FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc")
    perform_auto_provision host, r1
    assert_equal host.name, "macaabbccddeeff"
  end

  test "hostname is rendered after auto provisioning" do
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host_and_facts(facts).first
    r1 = FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc", :hostname => 'x<%= 1+1 %>')
    perform_auto_provision host, r1
    assert_equal host.name, "x2"
  end

end
