require_relative '../test_plugin_helper'

class DiscoveryTaxonomyExtensionsTest < ActiveSupport::TestCase
  include FactImporterIsolation
  allow_transactions_for_any_importer

  setup do
    @facts = parse_json_fixture('regular_host', true)
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
end
