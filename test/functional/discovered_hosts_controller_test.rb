require 'test_plugin_helper'

class DiscoveredHostsControllerTest < ActionController::TestCase
  setup :initialize_host

  setup do
    @request.env['HTTP_REFERER'] = '/discovery_rules'
    FactoryGirl.create(:subnet, :network => "192.168.100.1", :mask => "255.255.255.0", :locations => [location_one], :organizations => [organization_one])
    @facts = {
      "interfaces"             => "lo,eth0",
      "ipaddress"              => "192.168.100.42",
      "ipaddress_eth0"         => "192.168.100.42",
      "macaddress_eth0"        => "AA:BB:CC:DD:EE:FF",
      "discovery_bootif"       => "AA:BB:CC:DD:EE:FF",
      "physicalprocessorcount" => "42",
      "discovery_version"      => "3.0.0",
    }
    set_default_settings
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.stubs(:reboot).returns(true)
  end

  def test_index
    get :index, {}, set_session_user_default_reader
    assert_response :success
  end

  def test_index_with_custom_column
    FactoryGirl.create(:setting,
                       :name => 'discovery_fact_column',
                       :value => "bios_vendor",
                       :category => 'Setting::Discovered')
    facts = @facts.merge({"bios_vendor" => "QEMU"})
    Host::Discovered.import_host(facts)
    get :index, {}, set_session_user_default_reader
    assert_select "td", /QEMU/
    assert_response :success
  end

  def test_show_multiple_actions
    host = Host::Discovered.import_host(@facts)
    [:multiple_destroy, :select_multiple_organization, :select_multiple_location].each do |path|
      xhr :post, path, {:host_ids => [host.id]}, set_session_user
      assert_response :success
      assert response.body =~ /#{host.name}/
    end
  end

  def test_show_page_categories
    host = Host::Discovered.import_host(@facts)
    get :show, {:id => host.id}, set_session_user_default_reader
    assert_select "#category-highlights" do
      assert_select "#fact-ipaddress" do
        assert_select "td", /192.168.100.42/
      end
    end
    assert_response :success
  end

  def test_edit_form_elements
    host = Host::Discovered.import_host(@facts)
    get :edit, {:id => host.id}, set_session_user_default_manager
    assert_select "select" do |elements|
      elements.each do |element|
        assert_match(/^host_/, element.attributes['id'])
        assert_match(/^host\[/, element.attributes['name'])
      end
    end
  end

  def test_edit_form_attributes
    host = Host::Discovered.import_host(@facts)
    get :edit, {:id => host.id}, set_session_user_default_reader
    assert_not_nil host.cpu_count
  end

  def test_edit_form_quick_submit
    disable_taxonomies do
      host = Host::Discovered.import_host(@facts)
      domain = FactoryGirl.create(:domain)
      hostgroup = FactoryGirl.create(:hostgroup, :with_subnet, :with_environment, :with_rootpass, :with_os, :domain => domain)
      get :edit, {
        :id => host.id,
        :quick_submit => true,
        :host => {
          :hostgroup_id => hostgroup.id
        } }, set_session_user_default_manager

      managed_host = Host.find(host.id)
      assert managed_host.build
      assert_redirected_to host_url(managed_host)
      assert_equal hostgroup.id, managed_host.hostgroup_id
      assert_match /Successfully/, flash[:notice]
    end
  end

  def test_edit_form_submit_parameters
    host = Host::Discovered.import_host(@facts)
    hostgroup = setup_hostgroup(host)
    get :edit, {
      :id => host.id,
      :host => {
        :hostgroup_id => hostgroup.id
      } }, set_session_user_default_manager
    # all inherit buttons are pressed
    assert_select('button[name=is_overridden_btn]') do |e|
      e.attribute("class") =~ /active/
    end
    # particular fields are set
    assert_select '#host_hostgroup_id [selected]' do |e|
      assert_equal hostgroup.id.to_s, e.first[:value]
    end
    assert_select '#host_architecture_id [selected]' do |e|
      assert_equal hostgroup.architecture_id.to_s, e.first[:value]
    end
    assert_select '#host_operatingsystem_id [selected]' do |e|
      assert_equal hostgroup.operatingsystem_id.to_s, e.first[:value]
    end
    assert_select '#host_medium_id [selected]' do |e|
      assert_equal hostgroup.medium_id.to_s, e.first[:value]
    end
    assert_select '#host_ptable_id [selected]' do |e|
      assert_equal hostgroup.ptable_id.to_s, e.first[:value]
    end
    assert_select '#host_interfaces_attributes_0_domain_id [selected]' do |e|
      assert_equal hostgroup.domain_id.to_s, e.first[:value]
    end
  end

  def test_update_inheritance
    as_default_manager do
      host = Host::Discovered.import_host(@facts)
      hostgroup = setup_hostgroup(host)
      put :update, {
        commit: 'Update',
        id: host.id,
        host: {
          name: 'mytest',
          hostgroup_id: hostgroup.id
        }
      }, set_session_user(User.current)

      # Get the managed host instance from the DB
      actual = Host.find(host.id)

      assert_equal hostgroup.id, actual.hostgroup_id
      assert_equal hostgroup.architecture_id, actual.architecture_id
      assert_equal hostgroup.operatingsystem_id, actual.operatingsystem_id
      assert_equal hostgroup.medium_id, actual.medium_id
      assert_equal hostgroup.ptable_id, actual.ptable_id
      assert_equal hostgroup.domain_id, actual.domain_id
      assert_equal hostgroup.environment_id, actual.environment_id
      assert_equal hostgroup.puppet_proxy_id, actual.puppet_proxy_id
      assert_equal hostgroup.puppet_ca_proxy_id, actual.puppet_ca_proxy_id
    end
  end

  def test_add_entry_to_nav_menu
    get :index, {}, set_session_user
    assert_select "a[href=?]", "/discovered_hosts"
  end

  def test_reboot_success
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    host = Host::Discovered.import_host(@facts)
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.expects(:reboot).returns(true)
    post "reboot", { :id => host.id }, set_session_user_default_manager
    assert_redirected_to discovered_hosts_url
    assert_nil flash[:error]
    assert_equal "Rebooting host #{host.name}", flash[:notice]
  end

  def test_reboot_success_legacy
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    facts = @facts.merge({"somefact" => "abc", "discovery_version" => "2.9.9"})
    host = Host::Discovered.import_host(facts)
    Host::Discovered::any_instance.stubs(:proxied?).returns(false)
    Host::Discovered::any_instance.stubs(:proxy_url).returns("http://1.2.3.4:8443")
    ::ForemanDiscovery::NodeAPI::PowerLegacyDirectService.any_instance.expects(:reboot).returns(true)
    ActiveSupport::Deprecation.silence do
      post "reboot", { :id => host.id }, set_session_user
    end
    assert_redirected_to discovered_hosts_url
    assert_nil flash[:error]
    assert_equal "Rebooting host #{host.name}", flash[:notice]
  end

  def test_reboot_failure
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    host = Host::Discovered.import_host(@facts)
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.expects(:reboot).returns(false)
    post "reboot", { :id => host.id }, set_session_user_default_manager
    assert_redirected_to discovered_hosts_url
    assert_equal "Failed to reboot host #{host.name}", flash[:error]
  end

  def test_reboot_error
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    host = Host::Discovered.import_host(@facts)
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.expects(:reboot).raises("request failed")
    post "reboot", { :id => host.id }, set_session_user_default_manager
    assert_redirected_to discovered_hosts_url
    assert_match(/ERF50-4973/, flash[:error])
  end

  def test_auto_provision_success
    as_default_manager do
      disable_orchestration
      facts = @facts.merge({"somefact" => "abc"})
      host = Host::Discovered.import_host(facts)
      hostgroup = setup_hostgroup(host)
      FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc", :hostgroup => hostgroup, :organizations => [host.organization], :locations => [host.location])
      post :auto_provision, { :id => host.id }, set_session_user(User.current)
      assert_response :redirect
      assert_nil flash[:error]
      assert_match(/^Host macaabbccddeeff.* was provisioned/, flash[:notice])
      managed_host = Host.find(host.id)
      assert managed_host.build
    end
  end

  def test_auto_provision_no_rule_success
    as_default_manager do
      disable_orchestration
      facts = @facts.merge({"somefact" => "abc"})
      host = Host::Discovered.import_host(facts)
      post :auto_provision, { :id => host.id }, set_session_user(User.current)
    end
    assert_response :redirect
    assert_nil flash[:error]
    assert_equal "No rule found for host macaabbccddeeff", flash[:notice]
  end

  def test_auto_provision_all_success
    as_default_manager do
      disable_orchestration
      facts = @facts.merge({"somefact" => "abc"})
      host = Host::Discovered.import_host(facts)
      hostgroup = setup_hostgroup(host)
      FactoryGirl.create(
        :discovery_rule,
        :priority => 1,
        :search => "facts.somefact = abc",
        :hostgroup => hostgroup,
        :organizations => [host.organization], :locations => [host.location]
      )
      post :auto_provision_all, {}, set_session_user(User.current)
    end
    assert_response :redirect
    assert_nil flash[:error]
    assert_equal "Discovered hosts are provisioning now", flash[:notice]
  end

  def test_auto_provision_all_no_rule_success
    as_default_manager do
      disable_orchestration
      facts = @facts.merge({"somefact" => "abc"})
      host = Host::Discovered.import_host(facts)
      hostgroup = setup_hostgroup(host)
      FactoryGirl.create(
        :discovery_rule,
        :priority => 1,
        :search => "facts.somefact = abc",
        :hostgroup => hostgroup,
        :organizations => [host.organization], :locations => [host.location]
      )
      post :auto_provision_all, {}, set_session_user(User.current)
    end
    assert_response :redirect
    assert_nil flash[:error]
    assert_equal "Discovered hosts are provisioning now", flash[:notice]
  end

  def test_reboot_all_success
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    host = Host::Discovered.import_host(@facts)
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.expects(:reboot).returns(true)
    post "reboot", { :id => host.id }, set_session_user_default_manager
    assert_redirected_to discovered_hosts_url
    assert_equal "Rebooting host #{host.name}", flash[:notice]
    assert_nil flash[:error]
    assert_equal "Rebooting host macaabbccddeeff", flash[:notice]
  end

  def test_reboot_all_failure
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    host = Host::Discovered.import_host(@facts)
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.expects(:reboot).returns(false)
    post "reboot_all", { }, set_session_user_default_manager
    assert_redirected_to discovered_hosts_url
    assert_equal "Errors during reboot: #{host.name}: failed to reboot", flash[:error]
    assert_nil flash[:notice]
  end

  def test_reboot_all_error
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    Host::Discovered.import_host(@facts)
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.expects(:reboot).raises("request failed")
    post "reboot_all", { }, set_session_user_default_manager
    assert_redirected_to discovered_hosts_url
    assert_match(/ERF50-4973/, flash[:error])
    assert_nil flash[:notice]
  end

  def test_no_dns_rebuild_if_dns_pending
    as_default_manager do
      host = Host::Discovered.import_host(@facts)
      hostgroup = prepare_hostgroup_for_dns_rebuild(host)
      Nic::Managed.any_instance.expects(:rebuild_dns).never
      Host::Managed.any_instance.stubs(:skip_orchestration?).returns(false)
      put :update, {:commit => "Update", :id => host.id,
                    :host => {
        :name => 'mytest',
        :hostgroup_id => hostgroup.id,
      }
      }, set_session_user(User.current)
    end
  end

  def test_dns_rebuild
    as_default_manager do
      host = prepare_host_for_dns_rebuild
      hostgroup = prepare_hostgroup_for_dns_rebuild(host)
      Nic::Managed.any_instance.expects(:rebuild_dns)
      Host::Managed.any_instance.stubs(:skip_orchestration?).returns(false)
      put :update, {:commit => "Update", :id => host.id,
                    :host => {
        :name => 'mytest',
        :hostgroup_id => hostgroup.id,
      }
      }, set_session_user(User.current)
    end
  end

  def test_dns_rebuild_with_auto_provision
    as_default_manager do
      host = prepare_host_for_dns_rebuild
      hostgroup = prepare_hostgroup_for_dns_rebuild(host)
      Nic::Managed.any_instance.expects(:rebuild_dns)
      Host::Managed.any_instance.stubs(:skip_orchestration?).returns(false)
      FactoryGirl.create(:discovery_rule, :priority => 1, :search => "name = mytest.myorchdomain.net", :hostgroup_id => hostgroup.id, :organizations => [host.organization], :locations => [host.location])
      post :auto_provision, { :id => host.id }, set_session_user(User.current)
    end
  end

  private

  def initialize_host
    User.current = users(:admin)
  end

  def prepare_host_for_dns_rebuild
    host = Host::Discovered.import_host(@facts)
    host.name = 'mytest.myorchdomain.net'
    host.save
    host
  end

  def prepare_hostgroup_for_dns_rebuild(host)
    hostgroup = setup_hostgroup(host)
    hostgroup.domain = FactoryGirl.create(:domain, :name => 'myorchdomain.net', :dns => FactoryGirl.create(:smart_proxy, :features => [FactoryGirl.create(:feature, :dns)]))
    hostgroup
  end
end
