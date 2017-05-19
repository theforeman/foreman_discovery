require 'test_plugin_helper'

class DiscoveryRulesControllerTest < ActionController::TestCase
  setup :initialize_host

  test "should add a link to navigation" do
    get :index, {}, set_session_user
    assert_select "a[href=?]", "/discovery_rules"
  end

  test "reader role should get index" do
    get :index, {}, set_session_user_default_reader
    assert_response :success
    assert_not_nil assigns(:discovery_rules)
  end

  test "should get new" do
    get :new, {}, set_session_user_default_manager
    assert_response :success
  end

  test "should create discovery rule without taxonomy" do
    assert_difference('DiscoveryRule.unscoped.count') do
      post :create, {:discovery_rule => {
        :name => "foo",
        :search => "cpu_count = 42",
        :hostgroup_id => 1,
        :hostname => "",
        :priority => 1}}, set_session_user_default_manager
      assert_empty(extract_form_errors(response))
    end
    assert_redirected_to discovery_rules_path
  end

  test "should create discovery rule with taxonomy" do
    assert_difference('DiscoveryRule.unscoped.count') do
      hostgroup = FactoryGirl.create(:hostgroup, :with_os, :with_rootpass, :organizations => [organization_one], :locations => [location_one])
      post :create, {:discovery_rule => {
        :name => "foo",
        :search => "cpu_count = 42",
        :hostgroup_id => hostgroup.id,
        :organization_ids => [organization_one],
        :location_ids => [location_one.id],
        :hostname => "",
        :priority => 1}}, set_session_user_default_manager
      assert_empty(extract_form_errors(response))
    end
    assert_redirected_to discovery_rules_path
  end

  test "should get edit" do
    rule = FactoryGirl.create(:discovery_rule)
    get :edit, {:id => rule.id}, set_session_user_default_manager
    assert_response :success
  end

  test "should update discovery rule" do
    rule = FactoryGirl.create(:discovery_rule)
    put :update, {:id => rule.id, :discovery_rule => {:name => "new_name"}}, set_session_user_default_manager
    assert_nil flash[:error]
    assert_redirected_to discovery_rules_path
  end

  test "should destroy discovery rule" do
    rule = FactoryGirl.create(:discovery_rule)
    assert_difference('DiscoveryRule.unscoped.count', -1) do
      delete :destroy, {:id => rule.id}, set_session_user_default_manager
    end
    assert_nil flash[:error]
    assert_redirected_to discovery_rules_path
  end

  private

  def initialize_host
    User.current = users(:admin)
  end

end
