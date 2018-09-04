require_relative '../../../test_plugin_helper'

class Api::V2::SettingsControllerTest < ActionController::TestCase
  setup do
    FactoryBot.create(:setting, :name => 'discovery_prefix', :value => 'mac', :category => 'Setting::Discovered')
  end

  test_attributes :pid => '2c5ecb7e-87bc-4980-9620-7ae00e3f360e'
  test "should update hostname prefix without value" do
    setting = Setting.find_by_name("discovery_prefix")
    put :update, params: { :id => setting.id, :setting => { :value => '' } }
    assert_equal JSON.parse(@response.body)['value'], '', "Can't update discovery_prefix setting with empty value"
  end

  test_attributes :pid => '4969994d-f934-4f0e-9a98-476b87eb0527'
  test "should update hostname prefix" do
    value = RFauxFactory.gen_alpha
    setting = Setting.find_by_name("discovery_prefix")
    put :update, params: { :id => setting.id, :setting => { :value => value } }
    assert_equal JSON.parse(@response.body)['value'], value, "Can't update discovery_prefix setting with valid value #{value}"
  end
end
