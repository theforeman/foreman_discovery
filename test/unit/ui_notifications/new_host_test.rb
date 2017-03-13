require 'test_plugin_helper'

class NewHostNotificationTest < ActiveSupport::TestCase
  test 'new discovered host should generate a notification' do
    assert blueprint
    FactoryGirl.create :discovered_host
    assert_equal 1, blueprint.notifications.count
  end

  test 'multiple discovered hosts should generate only one notification' do
    host1 = FactoryGirl.create :discovered_host
    ForemanDiscovery::UINotifications::NewHost.deliver!(host1)
    expired_at = blueprint.notifications.first.expired_at
    Time.any_instance.stubs(:utc).returns(expired_at + 1.hour)
    host2 = FactoryGirl.create :discovered_host
    ForemanDiscovery::UINotifications::NewHost.deliver!(host2)
    assert_equal 1, blueprint.notifications.count
    assert_not_equal expired_at, blueprint.notifications.first.expired_at
  end

  private

  def blueprint
    NotificationBlueprint.find_by(name: 'new_discovered_host')
  end
end
