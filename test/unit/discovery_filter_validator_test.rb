require_relative '../test_plugin_helper'

class DiscoveryFilterValidatorTest < ActiveSupport::TestCase
  setup do
    @filter = FactoryBot.create(:filter, :search => "name = 'test'")
    @filter.permissions << Permission.find_by(name: 'view_discovered_hosts')
  end

  test "should not validate if search is blank" do
    filter = FactoryBot.build(:filter, resource_type: 'Host', search: nil)
    assert filter.valid?
  end

  test "should not validate if discovery permission is not present" do
    filter = FactoryBot.build(:filter, resource_type: 'Host', search: "name = 'test'")
    assert filter.valid?
  end

  test "run validation with invalid search" do
    filter = FactoryBot.build(:filter, resource_type: 'Host', search: "hostgroup = 'test'")
    filter.permissions << Permission.find_by(name: 'view_discovered_hosts')
    assert_not filter.valid?
    assert filter.errors[:search].present?
  end

  test "run validation with valid search" do
    filter = FactoryBot.build(:filter, resource_type: 'Host', search: "name = 'test'")
    filter.permissions << Permission.find_by(name: 'view_discovered_hosts')
    assert filter.valid?
    assert_empty filter.errors[:search]
  end
end
