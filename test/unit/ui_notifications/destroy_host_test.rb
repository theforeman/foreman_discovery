require_relative '../../test_plugin_helper'

class DestroyHostNotificationTest < ActiveSupport::TestCase
  alias_method  :blueprint, :discovered_notification_blueprint

  setup do
    assert blueprint
  end

  test 'destroying discovered host should remove notification' do
    host = FactoryBot.create(:discovered_host)
    ForemanDiscovery::UINotifications::NewHost.deliver!(host)
    assert_difference('blueprint.notifications.count', -1) do
      host.destroy
    end
  end

  test 'do not remove notification if other discovered hosts exists' do
    assert_difference('blueprint.notifications.count') do
      host = FactoryBot.create(:discovered_host)
      ForemanDiscovery::UINotifications::NewHost.deliver!(host)
    end
    assert_equal 1, blueprint.notifications.count
    Host::Discovered.destroy_all
    assert_equal 0, blueprint.notifications.count
  end

  test 'discovered host type change should update notifications' do
    host = FactoryBot.create(:discovered_host)
    ForemanDiscovery::UINotifications::NewHost.deliver!(host)
    assert_equal 1, blueprint.notifications.count
    new_host = ::ForemanDiscovery::HostConverter.to_managed(host, false, false)
    assert new_host.save!
    assert_equal 0, blueprint.notifications.count
  end

  test 'discovered host type must not update notifications on plain save' do
    host = FactoryBot.create(:discovered_host)
    ForemanDiscovery::UINotifications::NewHost.deliver!(host)
    assert_equal 1, blueprint.notifications.count
    host.name = "triggerchange"
    assert host.save!
    assert_equal 1, blueprint.notifications.count
  end

  test 'type change should not removing notifications for discovered hosts' do
    host1 = FactoryBot.create(:discovered_host)
    ForemanDiscovery::UINotifications::NewHost.deliver!(host1)
    host2 = FactoryBot.create(:discovered_host)
    ForemanDiscovery::UINotifications::NewHost.deliver!(host2)
    assert_equal 2, blueprint.notifications.count
    new_host = ::ForemanDiscovery::HostConverter.to_managed(host1, false, false)
    assert new_host.save!
    assert_equal 2, blueprint.notifications.count
  end
end
