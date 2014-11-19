require 'test_plugin_helper'

class DiscoveredHostsControllerTest < ActionController::TestCase
  setup :initialize_host
  
  setup do
    @request.env['HTTP_REFERER'] = '/discovery_rules'
    @facts = {
      "ipaddress" => "192.168.100.42",
      "macaddress" => "AA:BB:CC:DD:EE:FF",
      "discovery_bootif" => "AA:BB:CC:DD:EE:FF",
    }
  end

  def test_index
    get :index, {}, set_session_user
    assert_response :success
  end

  def test_index_json
    get :index, {:format => "json"}, set_session_user
    assert_response :success
  end

  def test_add_entry_to_nav_menu
    get :index, {}, set_session_user
    assert_tag :tag        => 'a',
               :attributes => { :href => '/discovered_hosts' }
  end

  def test_reboot_success
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    host = FactoryGirl.create(:host,
                              :ip   => '1.2.3.4',
                              :type => "Host::Discovered")
    ::ProxyAPI::BMC.any_instance.stubs(:power).returns(true)
    post "reboot", { :id => host.id }, set_session_user
    assert_redirected_to discovered_hosts_url
    assert_equal "Rebooting host #{host.name}", flash[:notice]
  end

  def test_reboot_failure
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    host = FactoryGirl.create(:host,
                              :ip   => '1.2.3.4',
                              :type => "Host::Discovered")
    ::ProxyAPI::BMC.any_instance.stubs(:power).returns(false)
    post "reboot", { :id => host.id }, set_session_user
    assert_redirected_to discovered_hosts_url
    assert_equal "Failed to reboot host #{host.name}", flash[:error]
  end

  def test_reboot_error
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    host = FactoryGirl.create(:host,
                              :ip   => '1.2.3.4',
                              :type => "Host::Discovered")
    ::ProxyAPI::BMC.any_instance.expects(:power).raises("request must fail")
    post "reboot", { :id => host.id }, set_session_user
    assert_redirected_to discovered_hosts_url
    assert_equal "Failed to reboot host #{host.name} with error request must fail", flash[:error]
  end

  def test_auto_provision_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host_and_facts(facts).first
    FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc", :hostgroup => hostgroups(:common))
    post :auto_provision, { :id => host.id }, set_session_user
    assert_response :redirect
    assert_nil flash[:error]
  end

  def test_auto_provision_no_rule_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host_and_facts(facts).first
    post :auto_provision, { :id => host.id }, set_session_user
    assert_response :redirect
    assert_nil flash[:error]
  end

  def test_auto_provision_all_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    Host::Discovered.import_host_and_facts(facts).first
    FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc", :hostgroup => hostgroups(:common))
    post :auto_provision_all, {}, set_session_user
    assert_response :redirect
    assert_nil flash[:error]
  end

  def test_auto_provision_all_no_rule_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    Host::Discovered.import_host_and_facts(facts).first
    FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc", :hostgroup => hostgroups(:common))
    post :auto_provision_all, {}, set_session_user
    assert_response :redirect
    assert_nil flash[:error]
  end

  private

  def initialize_host
    User.current = users(:admin)
  end
end
