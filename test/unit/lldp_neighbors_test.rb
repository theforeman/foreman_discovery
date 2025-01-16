require_relative '../test_plugin_helper'

class LldpNeighborsTest < ActiveSupport::TestCase
  include FactImporterIsolation
  allow_transactions_for_any_importer

  test "#get_neighbors_by_interface gives nothing with no LLDP facts" do
    assert_nil simple_facts.get_neighbors_by_interface('eth0')
  end

  test "#get_neighbors_by_interface gives nothing with unmatching PVID in LLDP facts" do
    assert_nil lldp_facts.get_neighbors_by_interface('eth0')
  end

  test "#get_neighbors_by_interface gives a valid pair for LLDP facts with matching PVID" do
    assert_equal %w(eth0 eth1), bond_facts.get_neighbors_by_interface('eth0')
    assert_equal %w(eth0 eth1), bond_facts.get_neighbors_by_interface('eth1')
    assert_nil bond_facts.get_neighbors_by_interface('br182')
  end

  test "#list_by_pvid gives an empty Hash without LLDP facts" do
    assert_equal({}, simple_facts.list_by_pvid)
    assert_equal({}, ForemanDiscovery::LldpNeighbors.from_facts({}).list_by_pvid)
  end

  test "#list_by_pvid gives an empty Hash without LLDP facts" do
    assert_equal({'182' => %w(eth2), '184' => %w(eth1)}, lldp_facts.list_by_pvid)
  end

  test "#list_by_pvid pairs interfaces by PVID" do
    assert_equal({'182' => %w(eth0 eth1)}, bond_facts.list_by_pvid)
  end

  test "#list_by_pvid supports multiple PVIDs" do
    assert_equal({'182' => %w(eth2), '184' => %w(eth1)}, lldp_facts.list_by_pvid)
  end

  test "#eventually_make_bond" do
    facts = parse_json_fixture('facts_with_lldp_bond_candidate', true)
    host = discover_host_from_facts(facts)
    primary = host.primary_interface

    assert_equal 0, host.interfaces.where(:type => 'Nic::Bond').count

    assert primary.primary
    assert primary.provision
    assert primary.ip
    assert primary.ip6

    ForemanDiscovery::LldpNeighbors.eventually_make_bond(host)

    bond = host.primary_interface

    assert_nil primary.ip
    assert_nil primary.ip6
    assert_nil primary.name
    assert_not primary.primary
    assert_not primary.provision
    assert_not primary.managed

    assert bond.primary
    assert bond.provision
    assert bond.ip
    assert bond.ip6
    assert_equal bond.type, 'Nic::Bond'
    assert_equal bond.identifier, 'bond0'
  end

  private

  def simple_facts
    neighbors 'regular_host'
  end

  def lldp_facts
    neighbors 'facts_with_lldp'
  end

  def bond_facts
    neighbors 'facts_with_lldp_bond_candidate'
  end

  def neighbors(name)
    ForemanDiscovery::LldpNeighbors.from_facts(parse_json_fixture(name, true))
  end
end
