require 'test_plugin_helper'

class DestroyHostNotificationTest < ActiveSupport::TestCase
  alias_method  :blueprint, :discovered_notification_blueprint

  setup do
    assert blueprint
  end

  test 'destorying discovered host should remove notification' do
    host = FactoryBot.create(:discovered_host)
    assert_difference('blueprint.notifications.count', -1) do
      host.destroy
    end
  end

  test 'do not remove notification if other discovered hosts exists' do
    assert_difference('blueprint.notifications.count') do
      FactoryBot.create(:discovered_host)
    end
    assert_equal 1, blueprint.notifications.count
    assert_no_difference('blueprint.notifications.count') do
      FactoryBot.create(:discovered_host)
    end
    assert_no_difference('blueprint.notifications.count') do
      Host::Discovered.all.last.destroy
    end
    Host::Discovered.destroy_all
    assert_equal 0, blueprint.notifications.count
  end

  test 'discovered host type change should update notifications' do
    host = FactoryBot.create(:discovered_host)
    assert_equal 1, blueprint.notifications.count
    new_host = ::ForemanDiscovery::HostConverter.to_managed(host, false, false)
    assert new_host.save!
    assert_equal 0, blueprint.notifications.count
  end

  test 'type change should not removing notifications for discovered hosts' do
    host1 = FactoryBot.create(:discovered_host)
    FactoryBot.create(:discovered_host)
    assert_equal 1, blueprint.notifications.count
    new_host = ::ForemanDiscovery::HostConverter.to_managed(host1, false, false)
    assert new_host.save!
    assert_equal 1, blueprint.notifications.count
  end
end
