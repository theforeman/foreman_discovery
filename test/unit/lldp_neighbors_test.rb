require_relative '../test_plugin_helper'

class LldpNeighborsTest < ActiveSupport::TestCase
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
    assert_empty(simple_facts.list_by_pvid)
    assert_empty(ForemanDiscovery::LldpNeighbors.from_facts({}).list_by_pvid)
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
