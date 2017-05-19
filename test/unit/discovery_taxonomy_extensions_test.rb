require 'test_plugin_helper'

class DiscoveryTaxonomyExtensionsTest < ActiveSupport::TestCase
  setup do
    set_default_settings
  end

  test 'deleting location does not hard fail if there is associated discovered host' do
    location = FactoryGirl.create(:location)

    raw = parse_json_fixture('/facts.json')
    assert (host = Host::Discovered.import_host(raw['facts']))
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
