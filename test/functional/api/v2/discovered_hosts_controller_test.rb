require 'test_helper'

class Api::V2::DiscoveredHostsControllerTest < ActionController::TestCase

  setup do
    User.current = User.find_by_login "admin"
    @request.env['HTTP_REFERER'] = '/discovery_rules'
    @facts = {
      "ipaddress" => "192.168.100.42",
      "macaddress" => "AA:BB:CC:DD:EE:FF",
      "discovery_bootif" => "AA:BB:CC:DD:EE:FF",
    }
    FactoryGirl.create(:setting,
                       :name => 'discovery_auto',
                       :value => true,
                       :category => 'Setting::Discovered')
  end

  test "should get index" do
    get :index, { }
    assert_response :success
  end

  def test_auto_provision_success_via_upload
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    FactoryGirl.create(:discovery_rule, :priority => 1, :name => 'rule', :search => "facts.somefact = abc", :hostgroup => hostgroups(:common))
    post :facts, { :facts => facts }
    assert_response :success
    assert_equal "Auto-discovered and provisioned via rule 'rule'", Host.first.comment
  end

  def test_auto_provision_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host_and_facts(facts).first
    FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc", :hostgroup => hostgroups(:common))
    post :auto_provision, { :id => host.id }
    assert_response :success
  end

  def test_auto_provision_no_rule_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host_and_facts(facts).first
    post :auto_provision, { :id => host.id }
    assert_response :success
  end

  def test_auto_provision_all_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    Host::Discovered.import_host_and_facts(facts).first
    FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc", :hostgroup => hostgroups(:common))
    post :auto_provision_all, {}
    assert_response :success
  end

  def test_auto_provision_all_no_rule_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    Host::Discovered.import_host_and_facts(facts).first
    post :auto_provision_all, {}
    assert_response :success
  end

end

