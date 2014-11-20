require 'test_helper'

class DummyPuppetFactParser
  def ip
    '192.168.0.30'
  end

  def primary_interface
    'eth1'
  end

  def interfaces
    {
      'eth0' => {'macaddress' => 'aa:00:00:00:00:01', 'ipaddress' => '192.168.0.2'},
      'eth3' => {'ipaddress' => '192.168.2.2'},
      'eth2' => {'macaddress' => 'bb:00:00:00:00:01', 'ipaddress' => '192.168.1.2'}
    }.with_indifferent_access
  end

  def facts
    {
      :ipaddress => '192.168.0.2', :macaddress => 'bb:00:00:00:00:01', :interfaces => 'eth0,eth1,lo',
      :macaddress_eth1 => 'bb:00:00:00:00:01', :ipaddress_eth1 => '192.168.1.2',
      :macaddress_eth0 => 'aa:00:00:00:00:01', :ipaddress_eth0 => '192.168.0.2',
      :macaddress_lo => '', :ipaddress_lo => '127.0.0.1',
      :mac_fact => 'AA:00:00:00:00:01'
    }.with_indifferent_access
  end

  include PuppetFactParserExtensions
end

class PuppetFactParserTest < ActiveSupport::TestCase
  setup do
    @parser = DummyPuppetFactParser.new
  end

  test '#ip_with_discovery_fact ignores discovery part completely if discovery facts are not present' do
    @parser.stubs(:discovery_mac_fact_name).returns('fact_that_does_not_exist')
    assert_equal '192.168.0.30', @parser.ip
  end

  test '#ip_with_discovery_fact finds primary interface based on discovery facts and returns it\'s ip' do
    @parser.stubs(:discovery_mac_fact_name).returns('mac_fact')
    assert_equal '192.168.0.2', @parser.ip
  end

  test '#primary_interface_with_discovery_fact finds primary interface based on discovery facts' do
    @parser.stubs(:discovery_mac_fact_name).returns('mac_fact')
    assert_equal 'eth0', @parser.primary_interface
  end

  test '#primary_interface_with_discovery_fact falls back if no interface can be found by discovery mac' do
    @parser.facts[:mac_fact] = 'cc:00:00:00:00:01'
    @parser.stubs(:discovery_mac_fact_name).returns('mac_fact')
    assert_equal 'eth0', @parser.primary_interface
  end

  test '#primary_interface_with_discovery_fact uses macaddress fact if discovery facts not available' do
    @parser.stubs(:discovery_mac_fact_name).returns('fact_that_does_not_exist')
    assert_equal 'eth1', @parser.primary_interface
  end
end
