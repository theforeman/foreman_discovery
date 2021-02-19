require_relative '../../test_plugin_helper'

class NewHostNotificationTest < ActiveSupport::TestCase
  include FactImporterIsolation
  allow_transactions_for_any_importer
  alias_method  :blueprint, :discovered_notification_blueprint

  setup do
    assert blueprint
  end

  test 'new discovered host should generate a notification' do
    set_default_settings
    assert_difference('blueprint.notifications.count') do
      discover_host_from_facts(parse_json_fixture('regular_host', true))
    end
  end

  test 'multiple discovered hosts should generate multiple notifications' do
    host1 = FactoryBot.create :discovered_host
    ForemanDiscovery::UINotifications::NewHost.deliver!(host1)
    expired_at = blueprint.notifications.first.expired_at
    Time.any_instance.stubs(:utc).returns(expired_at + 1.hour)
    host2 = FactoryBot.create :discovered_host
    ForemanDiscovery::UINotifications::NewHost.deliver!(host2)
    assert_equal 2, blueprint.notifications.count
    assert_not_equal expired_at, blueprint.notifications.last.expired_at
  end
end
