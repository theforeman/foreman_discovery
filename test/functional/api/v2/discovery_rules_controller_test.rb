require 'test_plugin_helper'

class Api::V2::DiscoveryRulesControllerTest < ActionController::TestCase
  setup do
    set_default_settings
  end

  test "should get index" do
    FactoryBot.create(:discovery_rule)
    get :index, params: { }
    assert_response :success
    assert_not_nil assigns(:discovery_rules)
    discovery_rules = ActiveSupport::JSON.decode(@response.body)
    assert !discovery_rules.empty?
  end

  test "should search discovery rule" do
    FactoryBot.create(:discovery_rule, :name => "test")
    get :index, params: { :search => "name = test"}
    assert_response :success
    discovery_rules = ActiveSupport::JSON.decode(@response.body)
    assert_equal 1, discovery_rules['total']
  end

  test "should show discovery rule with taxonomy" do
    rule = FactoryBot.create(:discovery_rule)
    get :show, params: { :id => rule.to_param }
    assert_response :success
    discovery_rule = ActiveSupport::JSON.decode(@response.body)
    assert_equal "Organization 1", discovery_rule['organizations'].first['name']
    assert_equal "Location 1", discovery_rule['locations'].first['name']
  end

  test_attributes :pid => 'b8ae7a80-b9a8-4924-808c-482a2b4102c4'
  test "should create discovery rule with name" do
    min_required_attr = { :name => 'new_rule', :search => 'CPU_Count = 1', :hostgroup_id => hostgroups(:unusual).id }
    assert_difference('DiscoveryRule.unscoped.count') do
      post :create, params: {:discovery_rule => min_required_attr}
    end
    assert_response :success
    response = JSON.parse(@response.body)
    assert response.key?('name')
    assert_equal min_required_attr[:name], response['name']
    assert response.key?('hostgroup_id')
    assert_equal min_required_attr[:hostgroup_id], response['hostgroup_id']
    assert response.key?('search')
    assert_equal min_required_attr[:search], response['search']
  end

  test_attributes :pid => '121e0a30-8a24-47d7-974d-998886ed1ea7'
  test "should create discovery rule with taxonomy" do
    assert_difference('DiscoveryRule.unscoped.count') do
      hostgroup = FactoryBot.create(:hostgroup, :with_os, :with_rootpass, :organizations => [organization_one], :locations => [location_one])
      post :create, params: {:discovery_rule => {
        :name => "foo",
        :search => "bar",
        :hostgroup_id => hostgroup.id,
        :organization_ids => [organization_one.id],
        :location_ids => [location_one.id],
        :hostname => "",
        :priority => 1}}
      refute_match /error/, response.body
    end
    assert_response :success
    response = JSON.parse(@response.body)
    assert response.key?('id')
    discovery_rule = DiscoveryRule.unscoped.find(response['id'])
    refute discovery_rule.nil?
    assert_equal organization_one.id, discovery_rule.organizations.first.id
    assert_equal location_one.id, discovery_rule.locations.first.id
  end

  test "should update discovery rule" do
    rule = FactoryBot.create(:discovery_rule)
    put :update, params: { :id => rule.to_param, :discovery_rule => { } }
    assert_response :success
  end

  test_attributes :pid => '769c0739-538b-4451-af7b-deb2ecd3dc0d'
  test "should update discovery rule name" do
    rule = FactoryBot.create(:discovery_rule)
    new_name = 'new_rule_name'
    put :update, params: { :id => rule.to_param, :discovery_rule => { :name => new_name } }
    assert_response :success
    rule.reload
    assert_equal new_name, rule.name
  end

  test "should update taxonomy for discovery rule" do
    rule = FactoryBot.create(:discovery_rule)
    put :update, params: { :id => rule.to_param, :discovery_rule => { :organization_ids => [rule.organizations.first.id] } }
    assert_response :success
  end

  test_attributes :pid => '0f8ec302-f9de-4713-87b7-0f1aca515149'
  test "should update taxonomies for discovery rule" do
    min_required_attr = { :name => 'new_rule', :search => 'CPU_Count = 1', :hostgroup_id => hostgroups(:unusual).id }
    rule = DiscoveryRule.new(min_required_attr)
    assert rule.save
    assert rule.organizations.empty?
    assert rule.locations.empty?
    hostgroup = FactoryBot.create(:hostgroup, :with_os, :with_rootpass, :organizations => [organization_one], :locations => [location_one])
    put :update, params: { :id => rule.to_param, :discovery_rule => {
      :organization_ids => [organization_one.id],
      :location_ids => [location_one.id],
      :hostgroup_id => hostgroup.id
    }}
    assert_response :success
    rule.reload
    assert_equal [organization_one.id], rule.organizations.map {|org| org.id}
    assert_equal [location_one.id], rule.locations.map {|loc| loc.id}
  end

  test_attributes :pid => '2c5ecb7e-87bc-4980-9620-7ae00e3f360e'
  test "should update search rule" do
    rule = FactoryBot.create(:discovery_rule)
    new_search = 'Location = Default_Location'
    put :update, params: { :id => rule.to_param, :discovery_rule => { :search => new_search } }
    assert_response :success
    rule.reload
    assert_equal new_search, rule.search
  end

  test_attributes :pid => '33084060-2866-46b9-bfab-23d91aea73d8'
  test "should update host limit" do
    rule = FactoryBot.create(:discovery_rule)
    new_max_count = 150
    assert_not_equal new_max_count, rule.max_count
    put :update, params: { :id => rule.to_param, :discovery_rule => { :max_count => new_max_count } }
    assert_response :success
    rule.reload
    assert_equal new_max_count, rule.max_count
  end

  test_attributes :pid => '330aa943-167b-46dd-b434-1a6e5fe8f283'
  test "test_positive_disable" do
    rule = FactoryBot.create(:discovery_rule)
    assert rule.enabled
    put :update, params: { :id => rule.to_param, :discovery_rule => { :enabled => false } }
    assert_response :success
    rule.reload
    refute rule.enabled
  end

  test_attributes :pid => '9fdba953-dcc7-4532-9204-17a45b0d9e05'
  test "should destroy discovery rule" do
    rule = FactoryBot.create(:discovery_rule)
    assert_difference('DiscoveryRule.unscoped.count', -1) do
      delete :destroy, params: { :id => rule.to_param }
    end
    assert_response :success
    assert_raise(ActiveRecord::RecordNotFound) { DiscoveryRule.unscoped.find(rule.id) }
  end

  test_attributes :pid => '415379b7-0134-40b9-adb1-2fe0adb1ac36'
  test "should not create with too long name" do
    assert_difference('DiscoveryRule.unscoped.count', 0) do
      post :create, params: {:discovery_rule => {
        :name => RFauxFactory.gen_alpha(256),
        :search => 'CPU_Count = 1',
        :hostgroup_id => hostgroups(:unusual).id
      }}
    end
    assert_response :unprocessable_entity
    assert_include @response.body, 'Name is too long (maximum is 255 characters)'
  end

  test_attributes :pid => '84503d8d-86f6-49bf-ab97-eff418d3e3d0'
  test "should not create with invalid host limit" do
    assert_difference('DiscoveryRule.unscoped.count', 0) do
      post :create, params: {:discovery_rule => {
        :name => 'new_rule',
        :search => 'CPU_Count = 1',
        :hostgroup_id => hostgroups(:unusual).id,
        :max_count => 'invalid max_count type'
      }}
    end
    assert_response :unprocessable_entity
    assert_include @response.body, 'Max count is not a number'
  end

  test_attributes :pid => '4ec7d76a-22ba-4c3e-952c-667a6f0a5728'
  test "should not create with invalid priority" do
    assert_difference('DiscoveryRule.unscoped.count', 0) do
      post :create, params: {:discovery_rule => {
        :name => 'new_rule',
        :search => 'CPU_Count = 1',
        :hostgroup_id => hostgroups(:unusual).id,
        :priority => 'invalid priority type'
      }}
    end
    assert_response :unprocessable_entity
    assert_include @response.body, 'Priority is not a number'
  end
end
