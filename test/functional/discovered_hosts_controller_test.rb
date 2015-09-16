require 'test_plugin_helper'

class DiscoveredHostsControllerTest < ActionController::TestCase
  setup :initialize_host

  setup do
    @request.env['HTTP_REFERER'] = '/discovery_rules'
    @facts = {
      "interfaces"             => "lo,eth0",
      "ipaddress"              => "192.168.100.42",
      "ipaddress_eth0"         => "192.168.100.42",
      "macaddress_eth0"        => "AA:BB:CC:DD:EE:FF",
      "discovery_bootif"       => "AA:BB:CC:DD:EE:FF",
      "physicalprocessorcount" => "42",
      "discovery_version"      => "3.0.0",
    }
    FactoryGirl.create(:setting,
                       :name => 'discovery_reboot',
                       :value => true,
                       :category => 'Setting::Discovered')
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.stubs(:reboot).returns(true)
  end

  def test_index
    get :index, {}, set_session_user
    assert_response :success
  end

  def test_index_with_custom_column
    FactoryGirl.create(:setting,
                       :name => 'discovery_fact_column',
                       :value => "bios_vendor",
                       :category => 'Setting::Discovered')
    facts = @facts.merge({"bios_vendor" => "QEMU"})
    Host::Discovered.import_host_and_facts(facts).first
    get :index, {}, set_session_user
    assert_select "td", /QEMU/
    assert_response :success
  end

  def test_edit_form_elements
    host = Host::Discovered.import_host_and_facts(@facts).first
    get :edit, {:id => host.id}, set_session_user
    assert_select "select" do |elements|
      elements.each do |element|
        assert_match(/^host_/, element.attributes['id'])
        assert_match(/^host\[/, element.attributes['name'])
      end
    end
  end

  def test_edit_form_attributes
    host = Host::Discovered.import_host_and_facts(@facts).first
    Host.transaction do
      get :edit, {:id => host.id}, set_session_user
    end
    assert_not_nil host.cpu_count
  end

  def test_add_entry_to_nav_menu
    get :index, {}, set_session_user
    assert_tag :tag        => 'a',
               :attributes => { :href => '/discovered_hosts' }
  end

  def test_reboot_success
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    host = Host::Discovered.import_host_and_facts(@facts).first
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.expects(:reboot).returns(true)
    post "reboot", { :id => host.id }, set_session_user
    assert_redirected_to discovered_hosts_url
    assert_nil flash[:error]
    assert_equal "Rebooting host #{host.name}", flash[:notice]
  end

  def test_reboot_success_legacy
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    facts = @facts.merge({"somefact" => "abc", "discovery_version" => "2.9.9"})
    host = Host::Discovered.import_host_and_facts(facts).first
    Host::Discovered::any_instance.stubs(:proxied?).returns(false)
    Host::Discovered::any_instance.stubs(:proxy_url).returns("http://1.2.3.4:8443")
    ::ForemanDiscovery::NodeAPI::PowerLegacyDirectService.any_instance.expects(:reboot).returns(true)
    post "reboot", { :id => host.id }, set_session_user
    assert_redirected_to discovered_hosts_url
    assert_nil flash[:error]
    assert_equal "Rebooting host #{host.name}", flash[:notice]
  end

  def test_reboot_failure
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    host = Host::Discovered.import_host_and_facts(@facts).first
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.expects(:reboot).returns(false)
    post "reboot", { :id => host.id }, set_session_user
    assert_redirected_to discovered_hosts_url
    assert_equal "Failed to reboot host #{host.name}", flash[:error]
  end

  def test_reboot_error
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    host = Host::Discovered.import_host_and_facts(@facts).first
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.expects(:reboot).raises("request failed")
    post "reboot", { :id => host.id }, set_session_user
    assert_redirected_to discovered_hosts_url
    assert_match(/ERF50-4973/, flash[:error])
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

  def test_reboot_all_success
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    host = Host::Discovered.import_host_and_facts(@facts).first
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.expects(:reboot).returns(true)
    post "reboot", { :id => host.id }, set_session_user
    assert_redirected_to discovered_hosts_url
    assert_equal "Rebooting host #{host.name}", flash[:notice]
  end

  def test_reboot_all_failure
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    host = Host::Discovered.import_host_and_facts(@facts).first
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.expects(:reboot).returns(false)
    post "reboot_all", { }, set_session_user
    assert_redirected_to discovered_hosts_url
    assert_equal "Errors during reboot: #{host.name}: failed to reboot", flash[:error]
  end

  def test_reboot_all_error
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    host = Host::Discovered.import_host_and_facts(@facts).first
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.expects(:reboot).raises("request failed")
    post "reboot_all", { }, set_session_user
    assert_redirected_to discovered_hosts_url
    assert_match(/ERF50-4973/, flash[:error])
  end

  private

  def initialize_host
    User.current = users(:admin)
  end
end
