require 'test_helper'
require 'test_helper_discovery'

class DiscoveryRulesControllerTest < ActionController::TestCase
  setup :initialize_host

  test "should add a link to navigation" do
    get :index, {}, set_session_user
    assert_tag :tag => 'a', :attributes => {:href => '/discovery_rules'}
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

  test "should create discovery rule" do
    assert_difference('DiscoveryRule.count') do
      post :create, {:discovery_rule => {
        :name => "foo",
        :search => "bar",
        :hostgroup_id => 1,
        :hostname => "",
        :priority => 1}}, set_session_user_default_manager
    end

    assert_redirected_to discovery_rules_path
  end

  test "should get edit" do
    rule = FactoryGirl.create(:discovery_rule)
    get :edit, {:id => rule.to_param}, set_session_user_default_manager
    assert_response :success
  end

  test "should update discovery rule" do
    rule = FactoryGirl.create(:discovery_rule)
    put :update, {:id => rule.to_param, :discovery_rule => {}}, set_session_user_default_manager
    assert_redirected_to discovery_rules_path
  end

  test "should destroy discovery rule" do
    rule = FactoryGirl.create(:discovery_rule)
    assert_difference('DiscoveryRule.count', -1) do
      delete :destroy, {:id => rule.to_param}, set_session_user_default_manager
    end

    assert_redirected_to discovery_rules_path
  end

  private

  def initialize_host
    User.current = users(:admin)
  end

end
