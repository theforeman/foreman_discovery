require 'test_plugin_helper'

class SettingDiscoveredTest < ActiveSupport::TestCase
  test "can create setting of discovered type" do
    assert Setting.create(:name => "foo", :default => "bar", :description => "test foo", :category => "Setting::Discovered")
    s = Setting::Discovered.first
    assert_equal "foo", s.name
  end
end
