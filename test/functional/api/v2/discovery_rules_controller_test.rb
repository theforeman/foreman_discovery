require 'test_helper'

class Api::V2::DiscoveryRulesControllerTest < ActionController::TestCase
  setup do
    User.current = User.find_by_login "admin"
    set_default_settings
  end

  test "should get index" do
    FactoryGirl.create(:discovery_rule)
    get :index, { }
    assert_response :success
    assert_not_nil assigns(:discovery_rules)
    discovery_rules = ActiveSupport::JSON.decode(@response.body)
    assert !discovery_rules.empty?
  end

  test "should search discovery rule" do
    FactoryGirl.create(:discovery_rule, :name => "test")
    get :index, { :search => "name = test"}
    assert_response :success
    discovery_rules = ActiveSupport::JSON.decode(@response.body)
    assert_equal 1, discovery_rules['total']
  end

  test "should show discovery rule" do
    rule = FactoryGirl.create(:discovery_rule)
    get :show, { :id => rule.to_param }
    assert_response :success
  end

  test "should create discovery rule with taxonomy" do
    assert_difference('DiscoveryRule.unscoped.count') do
      hostgroup = FactoryGirl.create(:hostgroup, :with_os, :with_rootpass, :organizations => [organization_one], :locations => [location_one])
      post :create, {:discovery_rule => {
        :name => "foo",
        :search => "bar",
        :hostgroup_id => hostgroup.id,
        :organization_ids => [organization_one],
        :location_ids => [location_one.id],
        :hostname => "",
        :priority => 1}}
    end
    assert_response :success
  end

  test "should update discovery rule" do
    rule = FactoryGirl.create(:discovery_rule)
    put :update, { :id => rule.to_param, :discovery_rule => { } }
    assert_response :success
  end

  test "should update taxonomy for discovery rule" do
    rule = FactoryGirl.create(:discovery_rule)
    organization = FactoryGirl.create(:organization)
    put :update, { :id => rule.to_param, :discovery_rule => { :organization_ids => [rule.organizations.first.id] } }
    assert_response :success
  end

  test "should destroy discovery rule" do
    rule = FactoryGirl.create(:discovery_rule)
    assert_difference('DiscoveryRule.unscoped.count', -1) do
      delete :destroy, { :id => rule.to_param }
    end
    assert_response :success
  end
end
