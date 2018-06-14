require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  test "should update hostname prefix with multiple valid values" do
    setting = FactoryBot.create(:setting, :name => 'discovery_prefix', :value => 'mac', :category => 'Setting::Discovered')
    RFauxFactory.gen_strings(exclude: [:numeric, :alphanumeric]).values.each do |value|
      setting.value = value
      assert setting.valid?, "Can't update discovery_prefix setting with valid value #{value}"
    end
  end
end
