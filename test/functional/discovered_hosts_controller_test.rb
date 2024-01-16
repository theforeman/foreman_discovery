require_relative '../test_plugin_helper'

class DiscoveredHostsControllerTest < ActionController::TestCase
  include FactImporterIsolation
  allow_transactions_for_any_importer
  setup :initialize_host

  setup do
    assert discovered_notification_blueprint
    @request.env['HTTP_REFERER'] = '/discovery_rules'
    FactoryBot.create(:subnet, :dhcp, :network => "192.168.100.1", :mask => "255.255.255.0", :locations => [location_one], :organizations => [organization_one])
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
    get :index, params: {}, session: set_session_user_default_reader
    assert_response :success
  end

  def test_index_with_custom_column
    Setting['discovery_fact_column'] = ["bios_vendor"]
    facts = @facts.merge({"bios_vendor" => "QEMU"})
    discover_host_from_facts(facts)
    get :index, params: {}, session: set_session_user_default_reader
    assert_select "td", /QEMU/
    assert_response :success
  end

  def test_show_multiple_actions
    host = discover_host_from_facts(@facts)
    [:multiple_destroy, :select_multiple_organization, :select_multiple_location].each do |action|
      process action, method: :post, params: {:host_ids => [host.id]}, session: set_session_user, xhr: true
      assert_response :success
      assert_includes(response.body, host.name)
    end
  end

  def test_show_page_categories
    host = discover_host_from_facts(@facts)
    get :show, params: {:id => host.id}, session: set_session_user_default_reader
    assert_select "#category-highlights" do
      assert_select "#fact-ipaddress" do
        assert_select "td", /192.168.100.42/
      end
    end
    assert_response :success
  end

  def test_edit_form_elements
    host = discover_host_from_facts(@facts)
    get :edit, params: {:id => host.id}, session: set_session_user_default_manager
    assert_select "select" do |elements|
      elements.each do |element|
        assert_match(/^host_/, element.attributes['id'])
        assert_match(/^host\[/, element.attributes['name'])
      end
    end
  end

  def test_edit_form_attributes
    host = discover_host_from_facts(@facts)
    get :edit, params: {:id => host.id}, session: set_session_user_default_reader
    assert_not_nil host.cpu_count
  end

  def test_edit_form_build_mode_enabled
    host = discover_host_from_facts(@facts)
    get :edit, params: {:id => host.id}, session: set_session_user_default_manager
    assert_response :success
    assert_select 'input[type=checkbox][checked=checked]#host_build'
  end

  def test_edit_form_quick_submit
    domain = FactoryBot.create(:domain)
    if defined? ForemanPuppet
      hostgroup = FactoryBot.create(:hostgroup, :with_subnet, :with_puppet_enc, :with_rootpass, :with_os, :domain => domain)
    else
      hostgroup = FactoryBot.create(:hostgroup, :with_subnet, :with_rootpass, :with_os, :domain => domain)
    end
    new_ip = hostgroup.subnet.ipaddr.to_s
    host = discover_host_from_facts(@facts.merge({
                                                    'ipaddress' => new_ip,
                                                    'ipaddress_eth0' => new_ip
                                                  }))
    get :edit, params: {
      :id => host.id,
      :quick_submit => true,
      :host => {
        :hostgroup_id => hostgroup.id
      } }, session: set_session_user_default_manager

    managed_host = Host.find(host.id)
    assert managed_host.build
    assert_redirected_to host_details_page_path(managed_host)
    assert_equal hostgroup.id, managed_host.hostgroup_id
    assert_match(/Successfully/, flash[:success])
  end

  def test_edit_form_submit_parameters
    host = discover_host_from_facts(@facts)
    hostgroup = setup_hostgroup(host)
    get :edit, params: {
      :id => host.id,
      :host => {
        :hostgroup_id => hostgroup.id
      } }, session: set_session_user_default_manager
    # all inherit buttons are pressed
    assert_select('button[name=is_overridden_btn]') do |e|
      e.attribute("class").to_s =~ /active/
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
    host = discover_host_from_facts(@facts)
    ForemanDiscovery::HostConverter.stubs(:unused_ip_for_subnet).returns(host.ip)
    hostgroup = setup_hostgroup(host)
    put :update, params: {
      commit: 'Update',
      id: host.id,
      host: {
        name: 'mytest',
        hostgroup_id: hostgroup.id
      }
    }, session: set_session_user(User.current)

    # Get the managed host instance from the DB
    actual = Host.find(host.id)

    assert_equal hostgroup.id, actual.hostgroup_id
    assert_equal hostgroup.architecture_id, actual.architecture_id
    assert_equal hostgroup.operatingsystem_id, actual.operatingsystem_id
    assert_equal hostgroup.medium_id, actual.medium_id
    assert_equal hostgroup.ptable_id, actual.ptable_id
    assert_equal hostgroup.domain_id, actual.domain_id
    if defined?(ForemanPuppet)
      assert_equal hostgroup.environment_id, actual.environment_id
      assert_equal hostgroup.puppet_proxy_id, actual.puppet_proxy_id
      assert_equal hostgroup.puppet_ca_proxy_id, actual.puppet_ca_proxy_id
    end
  end

  def test_add_entry_to_nav_menu
    get :index, params: {}, session: set_session_user
    assert_response :success
    assert response.body.include?('Discovered Hosts')
  end

  def test_reboot_success
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    host = discover_host_from_facts(@facts)
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.expects(:reboot).returns(true)
    post :reboot, params: { :id => host.id }, session: set_session_user_default_manager
    assert_redirected_to discovered_hosts_url
    assert_nil flash[:error]
    assert_equal "Rebooting host #{host.name}", flash[:success]
  end

  def test_reboot_failure
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    host = discover_host_from_facts(@facts)
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.expects(:reboot).returns(false)
    post :reboot, params: { :id => host.id }, session: set_session_user_default_manager
    assert_redirected_to discovered_hosts_url
    assert_match(/ERF42-4036/, flash[:error])
  end

  def test_reboot_error
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    host = discover_host_from_facts(@facts)
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.expects(:reboot).raises("request failed")
    post :reboot, params: { :id => host.id }, session: set_session_user_default_manager
    assert_redirected_to discovered_hosts_url
    assert_match(/ERF42-4036/, flash[:error])
  end

  def test_auto_provision_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    hostgroup = setup_hostgroup(host)
    FactoryBot.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc", :hostgroup => hostgroup, :organizations => [host.organization], :locations => [host.location])
    post :auto_provision, params: { :id => host.id }, session: set_session_user(User.current)
    assert_response :redirect
    assert_nil flash[:error]
    assert_match(/^Host macaabbccddeeff.* was provisioned/, flash[:success])
    managed_host = Host.find(host.id)
    assert managed_host.build
  end

  def test_auto_provision_no_rule_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    post :auto_provision, params: { :id => host.id }, session: set_session_user(User.current)
    assert_response :redirect
    assert_nil flash[:error]
    assert_equal "No rule found for host macaabbccddeeff", flash[:success]
  end

  def test_multiple_auto_provision_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    hostgroup = setup_hostgroup(host)
    FactoryBot.create(
      :discovery_rule,
      :priority => 1,
      :search => "facts.somefact = abc",
      :hostgroup => hostgroup,
      :organizations => [host.organization], :locations => [host.location]
    )
    post :submit_multiple_auto_provision, params: {:host_ids => host.id}, session: set_session_user(User.current)
    assert_response :redirect
    assert_nil flash[:error]
    assert_equal "Discovered hosts are provisioning now", flash[:success]
  end

  def test_multiple_auto_provision_no_rule_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    hostgroup = setup_hostgroup(host)
    FactoryBot.create(
      :discovery_rule,
      :priority => 1,
      :search => "facts.somefact = abc",
      :hostgroup => hostgroup,
      :organizations => [host.organization], :locations => [host.location]
    )
    post :submit_multiple_auto_provision, params: {:host_ids => host.id}, session: set_session_user(User.current)
    assert_response :redirect
    assert_nil flash[:error]
    assert_equal "Discovered hosts are provisioning now", flash[:success]
  end

  def test_multiple_reboot_success
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    host = discover_host_from_facts(@facts)
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.expects(:reboot).returns(true)
    post :submit_multiple_reboot, params: {:host_ids => host.id}, session: set_session_user(User.current)
    assert_redirected_to discovered_hosts_url
    assert_nil flash[:error]
    assert_equal "Discovered hosts are rebooting now", flash[:success]
  end

  def test_multiple_reboot_failure
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    host = discover_host_from_facts(@facts)
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.expects(:reboot).returns(false)
    post :submit_multiple_reboot, params: {:host_ids => host.id}, session: set_session_user(User.current)
    assert_redirected_to discovered_hosts_url
    assert_match(/ERF42-4036/, flash[:error])
    assert_nil flash[:success]
  end

  def test_multiple_reboot_error
    @request.env["HTTP_REFERER"] = discovered_hosts_url
    host = discover_host_from_facts(@facts)
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.expects(:reboot).raises("request failed")
    post :submit_multiple_reboot, params: {:host_ids => host.id}, session: set_session_user(User.current)
    assert_redirected_to discovered_hosts_url
    assert_match(/ERF42-4036/, flash[:error])
    assert_nil flash[:success]
  end

  def test_no_dns_rebuild_if_dns_pending
    host = discover_host_from_facts(@facts)
    ForemanDiscovery::HostConverter.stubs(:unused_ip_for_subnet).returns(host.ip)
    Nic::Managed.any_instance.stubs(:dhcp_update_required?).returns(false)
    Net::DHCP::Record.any_instance.stubs(:conflicting?).returns(false)
    hostgroup = prepare_hostgroup_for_dns_rebuild(host)
    Nic::Managed.any_instance.expects(:rebuild_dns).never
    Host::Managed.any_instance.stubs(:skip_orchestration?).returns(false)
    Host::Managed.any_instance.stubs(:queue_puppetca_create).returns(true)
    Host::Managed.any_instance.stubs(:queue_puppetca_certname_reset).returns(true)
    Host::Managed.any_instance.stubs(:queue_puppetca_autosign_destroy).returns(true)
    ProxyAPI::DNS.any_instance.stubs(:set).returns(true)
    put :update, params: {:commit => "Update", :id => host.id,
                  :host => {
      :name => 'mytest',
      :hostgroup_id => hostgroup.id,
    }
    }, session: set_session_user(User.current)
  end

  def test_dns_rebuild
    host = prepare_host_for_dns_rebuild
    ForemanDiscovery::HostConverter.stubs(:unused_ip_for_subnet).returns(host.ip)
    Nic::Managed.any_instance.stubs(:dhcp_update_required?).returns(false)
    Net::DHCP::Record.any_instance.stubs(:conflicting?).returns(false)
    hostgroup = prepare_hostgroup_for_dns_rebuild(host)
    Nic::Managed.any_instance.expects(:rebuild_dns)
    Host::Managed.any_instance.stubs(:skip_orchestration?).returns(false)
    put :update, params: {:commit => "Update", :id => host.id,
                  :host => {
      :name => 'mytest',
      :hostgroup_id => hostgroup.id,
    }
    }, session: set_session_user(User.current)
  end

  def test_dns_rebuild_with_auto_provision
    host = prepare_host_for_dns_rebuild
    ForemanDiscovery::HostConverter.stubs(:unused_ip_for_subnet).returns(host.ip)
    Nic::Managed.any_instance.stubs(:dhcp_update_required?).returns(false)
    hostgroup = prepare_hostgroup_for_dns_rebuild(host)
    Nic::Managed.any_instance.expects(:rebuild_dns)
    Host::Managed.any_instance.stubs(:skip_orchestration?).returns(false)
    FactoryBot.create(:discovery_rule, :priority => 1, :search => "name = mytest.myorchdomain.net", :hostgroup_id => hostgroup.id, :organizations => [host.organization], :locations => [host.location])
    post :auto_provision, params: { :id => host.id }, session: set_session_user(User.current)
  end

  private

  def initialize_host
    User.current = users(:admin)
  end

  def prepare_host_for_dns_rebuild
    host = discover_host_from_facts(@facts)
    host.name = 'mytest.myorchdomain.net'
    host.save
    host
  end

  def prepare_hostgroup_for_dns_rebuild(host)
    hostgroup = setup_hostgroup(host)
    hostgroup.domain = FactoryBot.create(:domain, :name => 'myorchdomain.net', :dns => FactoryBot.create(:smart_proxy, :features => [FactoryBot.create(:feature, :dns)]))
    hostgroup.save
    hostgroup
  end
end
