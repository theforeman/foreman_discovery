require_relative '../test_plugin_helper'

class DiscoveryRulesControllerTest < ActionController::TestCase
  setup :initialize_host

  test "should add a link to navigation" do
    get :index, params: {}, session: set_session_user
    assert_response :success
    assert_includes(response.body, '/discovery_rules/')
  end

  test "reader role should get index" do
    get :index, params: {}, session: set_session_user_default_reader
    assert_response :success
  end

  test "should get new" do
    get :new, params: {}, session: set_session_user_default_manager
    assert_response :success
  end

  test "should not create discovery rule without taxonomy" do
    assert_difference('DiscoveryRule.unscoped.count', 0) do
      DiscoveryRule.any_instance.stubs(:set_current_taxonomy).returns(true)
      post :create, params: {:discovery_rule => {
        :name => "foo",
        :search => "cpu_count = 42",
        :hostgroup_id => 1,
        :hostname => "",
        :priority => 1}}, session: set_session_user_default_manager
      assert_not_empty(extract_form_errors(response))
    end
    assert_template :new
  end

  test "should create discovery rule with taxonomy" do
    assert_difference('DiscoveryRule.unscoped.count') do
      hostgroup = FactoryBot.create(:hostgroup, :with_os, :with_rootpass, :organizations => [organization_one], :locations => [location_one])
      post :create, params: {:discovery_rule => {
        :name => "foo",
        :search => "cpu_count = 42",
        :hostgroup_id => hostgroup.id,
        :organization_ids => [organization_one],
        :location_ids => [location_one.id],
        :hostname => "",
        :priority => 1}}, session: set_session_user_default_manager
      assert_empty(extract_form_errors(response))
    end
    assert_redirected_to discovery_rules_path
  end

  test "should get edit" do
    rule = FactoryBot.create(:discovery_rule)
    get :edit, params: {:id => rule.id}, session: set_session_user_default_manager
    assert_response :success
  end

  test "should update discovery rule" do
    rule = FactoryBot.create(:discovery_rule)
    put :update, params: {:id => rule.id, :discovery_rule => {:name => "new_name"}}, session: set_session_user_default_manager
    assert_nil flash[:error]
    assert_redirected_to discovery_rules_path
  end

  test "should destroy discovery rule" do
    rule = FactoryBot.create(:discovery_rule)
    assert_difference('DiscoveryRule.unscoped.count', -1) do
      delete :destroy, params: {:id => rule.id}, session: set_session_user_default_manager
    end
    assert_nil flash[:error]
    assert_redirected_to discovery_rules_path
  end

  test 'clone' do
    rule = FactoryBot.create(:discovery_rule)
    get :clone, params: { :id => rule.id }, session: set_session_user
    assert_template 'clone'
  end

  private

  def initialize_host
    User.current = users(:admin)
  end

end
