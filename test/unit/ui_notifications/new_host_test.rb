require 'test_plugin_helper'

class NewHostNotificationTest < ActiveSupport::TestCase
  alias_method  :blueprint, :discovered_notification_blueprint

  setup do
    assert blueprint
  end

  test 'new discovered host should generate a notification' do
    set_default_settings
    FactImporter.any_instance.expects(:ensure_no_active_transaction).
      returns(true).at_least_once
    assert_difference('blueprint.notifications.count') do
      discover_host_from_facts(parse_json_fixture('/../facts.json')['facts'])
    end
  end

  test 'multiple discovered hosts should generate only one notification' do
    host1 = FactoryBot.create :discovered_host
    ForemanDiscovery::UINotifications::NewHost.deliver!(host1)
    expired_at = blueprint.notifications.first.expired_at
    Time.any_instance.stubs(:utc).returns(expired_at + 1.hour)
    host2 = FactoryBot.create :discovered_host
    ForemanDiscovery::UINotifications::NewHost.deliver!(host2)
    assert_equal 1, blueprint.notifications.count
    assert_not_equal expired_at, blueprint.notifications.first.expired_at
  end

  def parse_json_fixture(relative_path)
    return JSON.parse(File.read(File.expand_path(File.dirname(__FILE__) + relative_path)))
  end
end
