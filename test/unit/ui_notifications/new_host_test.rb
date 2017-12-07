require 'test_plugin_helper'

class NewHostNotificationTest < ActiveSupport::TestCase
  alias_method  :blueprint, :discovered_notification_blueprint

  setup do
    assert blueprint
  end

  test 'new discovered host should generate a notification' do
    assert_difference('blueprint.notifications.count') do
      FactoryBot.create :discovered_host
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
end
