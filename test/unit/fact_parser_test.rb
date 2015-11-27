require 'test_helper'

class FactParserTest < ActiveSupport::TestCase
  setup do
    interfaces = {
      'eth0' => {'macaddress' => 'aa:bb:cc:dd:ee:f1', 'ipaddress' => '192.168.1.1'},
      'eth1' => {'macaddress' => 'aa:bb:cc:dd:ee:f2', 'ipaddress' => '192.168.1.2'},
      'eth2' => {'macaddress' => 'aa:bb:cc:dd:ee:f3', 'ipaddress' => '192.168.1.3'},
    }.with_indifferent_access
    facts = {
      :macaddress_eth0 => 'aa:bb:cc:dd:ee:f1',
      :macaddress_eth1 => 'aa:bb:cc:dd:ee:f2',
      :macaddress_eth2 => 'aa:bb:cc:dd:ee:f3',
      :ipaddress_eth0 => '192.168.1.1',
      :ipaddress_eth1 => '192.168.1.2',
      :ipaddress_eth2 => '192.168.1.3',
      :ipaddress => '192.168.1.2',
      :macaddress => 'aa:bb:cc:dd:ee:f2',
      :discovery_bootif => 'aa:bb:cc:dd:ee:f3'
    }.with_indifferent_access
    @parser = ::ForemanDiscovery::FactParser.new(facts)
    @parser.stubs(:interfaces).returns(interfaces)
    @host = Host::Discovered.new(:name => 'dummy')
  end

  test "#suggested_primary_interface detects interface eth2" do
    assert_equal 'eth2', @parser.suggested_primary_interface(@host).try(:first)
  end

  test "#suggested_primary_interface detects interface eth1" do
    FacterUtils.stubs(:bootif_mac).returns('aa:bb:cc:dd:ee:f2')
    assert_equal 'eth1', @parser.suggested_primary_interface(@host).try(:first)
  end

  test "#suggested_primary_interface detects interface with user defined bootif fact name" do
    FacterUtils.stubs(:bootif_name).returns('my_primary')
    @parser.facts[:my_primary] = 'aa:bb:cc:dd:ee:f1'
    assert_equal 'eth0', @parser.suggested_primary_interface(@host).try(:first)
  end

  test "#suggested_primary_interface errors out when bootif fact defines unknown MAC" do
    @parser.facts[:discovery_bootif] = 'aa:aa:aa:aa:aa:aa'
    exception = assert_raises(::Foreman::Exception) do
      @parser.suggested_primary_interface(@host)
    end
    assert_match(/Unable to detect primary interface using MAC/, exception.message)
  end

  test "#suggested_primary_interface errors out when bootif fact is missing" do
    @parser.facts.delete(:discovery_bootif)
    exception = assert_raises(::Foreman::Exception) do
      @parser.suggested_primary_interface(@host)
    end
    assert_match(/Unable to detect primary interface using MAC/, exception.message)
  end

  test "#suggested_primary_interface detects interface even when 'ignore_puppet_facts_for_provisioning' is set" do
    FactoryGirl.create(:setting,
                       :name => 'ignore_puppet_facts_for_provisioning',
                       :value => true,
                       :category => 'Setting::Provisioning')
    assert_equal 'eth2', @parser.suggested_primary_interface(@host).try(:first)
  end

end
