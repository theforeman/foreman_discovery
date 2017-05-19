require 'test_plugin_helper'

class DestroyHostNotificationTest < ActiveSupport::TestCase
  test 'destorying discovered host should remove notification' do
    host = FactoryGirl.create(:discovered_host)
    assert_difference('blueprint.notifications.count', -1) do
      host.destroy
    end
  end

  test 'do not remove notification if others discovered hosts exists' do
    host1 = FactoryGirl.create(:discovered_host)
    assert_equal 1, blueprint.notifications.count
    host2 = FactoryGirl.create(:discovered_host)
    assert_equal 1, blueprint.notifications.count
    host2.destroy
    assert_equal 1, blueprint.notifications.count
    host1.destroy
    assert_equal 0, blueprint.notifications.count
  end

  test 'discovered host type change should update notifications' do
    host = FactoryGirl.create(:discovered_host)
    assert_equal 1, blueprint.notifications.count
    new_host = ::ForemanDiscovery::HostConverter.to_managed(host, false, false)
    assert new_host.save!
    assert_equal 0, blueprint.notifications.count
  end

  test 'type change should not removing notifications for discovered hosts' do
    host1 = FactoryGirl.create(:discovered_host)
    FactoryGirl.create(:discovered_host)
    assert_equal 1, blueprint.notifications.count
    new_host = ::ForemanDiscovery::HostConverter.to_managed(host1, false, false)
    assert new_host.save!
    assert_equal 1, blueprint.notifications.count
  end

  private

  def blueprint
    NotificationBlueprint.find_by(name: 'new_discovered_host')
  end
end
