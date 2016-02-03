require 'test_helper'

class DiscoveryAttributeSetTest < ActiveSupport::TestCase

  setup do
    FactoryGirl.create(:setting,
                       :name => 'discovery_hostname',
                       :value => 'discovery_bootif',
                       :category => 'Setting::Discovered')
    FactoryGirl.create(:setting,
                       :name => 'discovery_prefix',
                       :value => 'mac',
                       :category => 'Setting::Discovered')
  end

  test "can search discovered hosts by cpu" do
    raw = parse_json_fixture('/facts.json')
    host = Host::Discovered.import_host_and_facts(raw['facts']).first
    results = Host::Discovered.search_for("cpu_count = #{host.facts_hash['physicalprocessorcount'].to_i}")
    assert_equal 1, results.count
    results = Host::Discovered.search_for("cpu_count > #{host.facts_hash['physicalprocessorcount'].to_i}")
    assert_equal 0, results.count
  end

  test "can search discovered hosts by memory" do
    raw = parse_json_fixture('/facts.json')
    host = Host::Discovered.import_host_and_facts(raw['facts']).first
    results = Host::Discovered.search_for("memory = #{host.facts_hash['memorysize_mb'].to_f.ceil}")
    assert_equal 1, results.count
    results = Host::Discovered.search_for("memory > #{host.facts_hash['memorysize_mb'].to_f.ceil}")
    assert_equal 0, results.count
  end

  test "can search discovered hosts by disk_count" do
    raw = parse_json_fixture('/facts.json')
    host = Host::Discovered.import_host_and_facts(raw['facts']).first
    results = Host::Discovered.search_for("disk_count = 1")
    assert_equal 1, results.count
    results = Host::Discovered.search_for("disk_count = 3")
    assert_equal 0, results.count
  end

  test "can search discovered hosts by disks_size" do
    raw = parse_json_fixture('/facts.json')
    host = Host::Discovered.import_host_and_facts(raw['facts']).first
    disks_size = (host.facts_hash['blockdevice_sda_size'].to_f / 1024 / 1024).ceil
    results = Host::Discovered.search_for("disks_size = #{disks_size}")
    assert_equal 1, results.count
    results = Host::Discovered.search_for("disks_size > #{disks_size}")
    assert_equal 0, results.count
  end

  def parse_json_fixture(relative_path)
    return JSON.parse(File.read(File.expand_path(File.dirname(__FILE__) + relative_path)))
  end
end
