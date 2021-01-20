require_relative '../test_plugin_helper'

class FactToCategoryResolverTest < ActiveSupport::TestCase
  class FakePrimaryInterface < OpenStruct
    def subnet
      nil
    end
  end

  setup do
    interfaces = [{
      identifier: 'eth0',
      mac: 'aa:bb:cc:dd:ee:f1',
      ip: '192.168.1.1',
    }.with_indifferent_access]
    facts = {
      :macaddress_eth0 => 'aa:bb:cc:dd:ee:f1',
      :ipaddress_eth0 => '192.168.1.1',
      manufacturer: 'TEST-Creator',
      hardwaremodel: 'TEST_X64',
      bios_vendor: 'TEST_BIOS',
    }.with_indifferent_access

    @host = Host::Discovered.new(name: 'dummy')
    @host.stubs(:facts_hash).returns(facts)
    @host.stubs(:interfaces).returns(interfaces)
    @host.stubs(:primary_interface).returns(FakePrimaryInterface.new)
    @resolver = ForemanDiscovery::FactToCategoryResolver.new(@host)
  end

  test 'resolve facts to right category' do
    categories = @resolver.categories
    hardware_category = categories[2]
    network_category = categories[3]
    software_category = categories[4]

    assert_equal hardware_category['hardwaremodel'], 'TEST_X64'
    assert_equal network_category['ipaddress_eth0'], '192.168.1.1'
    assert_equal software_category['bios_vendor'], 'TEST_BIOS'
  end
end
