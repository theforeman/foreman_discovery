require 'test_plugin_helper'

class DiscoveryTaxonomyExtensionsTest < ActiveSupport::TestCase
  setup do
    @facts = parse_json_fixture('/facts.json')['facts']
    set_default_settings
  end

  test 'deleting location does not hard fail if there is associated discovered host' do
    location = FactoryBot.create(:location)

    assert (host = discover_host_from_facts(@facts))
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
