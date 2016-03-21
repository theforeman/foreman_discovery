require 'test_helper'

class DiscoveryTaxonomyExtensionsTest < ActiveSupport::TestCase
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

  test 'deleting location does not hard fail if there is associated discovered host' do
    location = FactoryGirl.create(:location)

    raw = parse_json_fixture('/facts.json')
    assert (host = Host::Discovered.import_host_and_facts(raw['facts']).first)
    host.location = location
    assert host.save

    assert_nothing_raised do
      refute location.destroy, 'Location was destroyed but it should not be allowed'
    end
  end

  def parse_json_fixture(relative_path)
    return JSON.parse(File.read(File.expand_path(File.dirname(__FILE__) + relative_path)))
  end
end
