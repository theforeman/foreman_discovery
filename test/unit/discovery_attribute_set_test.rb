require_relative '../test_plugin_helper'

class DiscoveryAttributeSetTest < ActiveSupport::TestCase
  include FactImporterIsolation
  allow_transactions_for_any_importer

  setup do
    @facts = parse_json_fixture('regular_host', true)
    FactoryBot.create(:setting,
                       :name => 'discovery_hostname',
                       :value => 'discovery_bootif',
                       :category => 'Setting::Discovered')
    FactoryBot.create(:setting,
                       :name => 'discovery_prefix',
                       :value => 'mac',
                       :category => 'Setting::Discovered')
    ::ForemanDiscovery::HostConverter.stubs(:unused_ip_for_host)
  end

  test "can search discovered hosts by cpu" do
    host = discover_host_from_facts(@facts)
    results = Host::Discovered.unscoped.search_for("cpu_count = #{host.facts_hash['physicalprocessorcount'].to_i}")
    assert_equal 1, results.count
    results = Host::Discovered.unscoped.search_for("cpu_count > #{host.facts_hash['physicalprocessorcount'].to_i}")
    assert_equal 0, results.count
  end

  test "can search discovered hosts by memory" do
    host = discover_host_from_facts(@facts)
    results = Host::Discovered.unscoped.search_for("memory = #{host.facts_hash['memorysize_mb'].to_f.ceil}")
    assert_equal 1, results.count
    results = Host::Discovered.unscoped.search_for("memory > #{host.facts_hash['memorysize_mb'].to_f.ceil}")
    assert_equal 0, results.count
  end

  test "can search discovered hosts by disk_count" do
    host = discover_host_from_facts(@facts)
    results = Host::Discovered.unscoped.search_for("disk_count = 1")
    assert_equal 1, results.count
    results = Host::Discovered.unscoped.search_for("disk_count = 3")
    assert_equal 0, results.count
  end

  test "can search discovered hosts by disks_size" do
    begin
      excluded = Setting[:excluded_facts]
      Setting[:excluded_facts] = ["test"]
      host = discover_host_from_facts(@facts)
      disks_size = (host.facts_hash['blockdevice_sda_size'].to_f / 1024 / 1024).ceil
      results = Host::Discovered.unscoped.search_for("disks_size = #{disks_size}")
      assert_equal 1, results.count
      results = Host::Discovered.unscoped.search_for("disks_size > #{disks_size}")
      assert_equal 0, results.count
    ensure
      Setting[:excluded_facts] = excluded
    end
  end
end
