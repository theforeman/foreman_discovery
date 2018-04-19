require 'test_plugin_helper'

class DiscoveryPermissionsTest < ActiveSupport::TestCase
  # Authorizable#permission_name will not work with edit_discovered_hosts and will break core tests
  test "permission name for discovery edit is edit_hosts" do
    discovered_host = FactoryBot.create(:discovered_host)
    assert_equal "edit_hosts", discovered_host.permission_name("edit")
    refute_equal "edit_discovered_hosts", discovered_host.permission_name("edit")
    refute_equal "create_discovered_hosts", discovered_host.permission_name("create")
  end

  test "default manager has all required permissions" do
    assert_equal Foreman::Plugin.find('foreman_discovery').default_roles['Discovery Manager'].map(&:to_s).uniq.sort, default_manager.permissions.pluck(:name).uniq.sort
    #@default_reader ||= user_with_perms(Foreman::Plugin.find('foreman_discovery').default_roles['Discovery Reader'])
  end
end
