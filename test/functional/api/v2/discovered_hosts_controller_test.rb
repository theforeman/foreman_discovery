require_relative '../../../test_plugin_helper'

class Api::V2::DiscoveredHostsControllerTest < ActionController::TestCase
  include FactImporterIsolation
  allow_transactions_for_any_importer

  def switch_controller(klass)
    old_controller = @controller
    @controller = klass.new
    yield
    @controller = old_controller
  end

  setup do
    FactoryBot.create(:subnet, :network => "192.168.100.1", :mask => "255.255.255.0", :locations => [location_one], :organizations => [organization_one])
    @request.env['HTTP_REFERER'] = '/discovery_rules'
    @facts = {
      "interfaces"        => "lo,eth0",
      "ipaddress"         => "192.168.100.42",
      "ipaddress_eth0"    => "192.168.100.42",
      "macaddress_eth0"   => "AA:BB:CC:DD:EE:FF",
      "discovery_bootif"  => "AA:BB:CC:DD:EE:FF",
      "memorysize_mb"     => "42000.42",
      "discovery_version" => "3.0.0",
    }
    set_default_settings
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.stubs(:reboot).returns(true)
  end

  def test_get_index
    get :index, params: { }
    assert_response :success
  end

  def test_show_host
    FactoryBot.create(:organization, :name => 'SomeOrg')
    FactoryBot.create(:location, :name => 'SomeLoc')
    host = discover_host_from_facts(@facts)
    get :show, params: { :id => host.id }
    assert_response :success
    show_response = ActiveSupport::JSON.decode(@response.body)
    assert_equal "macaabbccddeeff", show_response["name"]
    assert_equal 42001, show_response["memory"]
    assert_equal 0, show_response["disk_count"]
    assert_equal 0, show_response["disks_size"]
    assert_equal Setting[:discovery_organization], show_response["organization_name"]
    assert_equal Setting[:discovery_location], show_response["location_name"]
  end

  def test_delete_discovered_host
    host = discover_host_from_facts(@facts)
    delete :destroy, params: { :id => host.id }
    assert_response :success
  end

  def test_provision_host
    FactoryBot.create(:organization, :name => 'SomeOrg')
    FactoryBot.create(:location, :name => 'SomeLoc')
    host = discover_host_from_facts(@facts)
    hostgroup = setup_hostgroup(host)
    put :update, params: {
        id: host.id,
        discovered_host: {
          hostgroup_id: hostgroup.id,
          build: true
        }
      }

    assert_match(/#{host.name}/, @response.body)
    assert_response :success

    # Get the managed host instance from the DB
    actual = Host.unscoped.find(host.id)

    assert_equal hostgroup.id, actual.hostgroup_id
    assert_equal hostgroup.architecture_id, actual.architecture_id
    assert_equal hostgroup.operatingsystem_id, actual.operatingsystem_id
    assert_equal hostgroup.medium_id, actual.medium_id
    assert_equal hostgroup.ptable_id, actual.ptable_id
    assert_equal hostgroup.domain_id, actual.domain_id
    assert_equal hostgroup.environment_id, actual.environment_id
    assert_equal hostgroup.puppet_proxy_id, actual.puppet_proxy_id
    assert_equal hostgroup.puppet_ca_proxy_id, actual.puppet_ca_proxy_id
    assert actual.build?
  end

  def test_provision_host_without_build_flag
    FactoryBot.create(:organization, :name => 'SomeOrg')
    FactoryBot.create(:location, :name => 'SomeLoc')
    host = discover_host_from_facts(@facts)
    hostgroup = setup_hostgroup(host)
    put :update, params: {
        id: host.id,
        discovered_host: {
          hostgroup_id: hostgroup.id,
          build: false
        }
      }
    assert_response :success
    actual = Host.unscoped.find(host.id)
    assert_equal hostgroup.id, actual.hostgroup_id
    refute actual.build?
  end

  def test_auto_provision_success_via_upload
    reset_api_credentials
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    taxonomy = { :organizations => [organization_one], :locations => [location_one] }
    DiscoveryRule.create({:priority => 1, :name => 'rule', :search => "facts.somefact = abc", :hostgroup => FactoryBot.create(:hostgroup, :with_os, :with_rootpass, taxonomy)}.merge(taxonomy))
    post :facts, params: { :facts => facts }

    assert_response :success
    actual = JSON.parse(response.body)
    assert_not_nil id = actual['id']
    assert !Host::Discovered.unscoped.where(id: id).exists?, 'discovered host still exists!'
    assert Host.unscoped.where(id: id).exists?, 'host was not auto provisioned!'
    assert_not_nil actual['created_at']
    assert_equal "Auto-discovered and provisioned via rule 'rule'", Host.unscoped.find(id).comment
  end

  def test_auto_provision_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc", "discovery_version" => "2.9.9"})
    host = discover_host_from_facts(facts)
    taxonomy = { :organizations => [host.organization], :locations => [host.location] }
    rule = FactoryBot.create(:discovery_rule, {:priority => 1, :search => "facts.somefact = abc", :hostgroup => FactoryBot.create(:hostgroup, :with_os, :with_rootpass, taxonomy)}.merge(taxonomy))
    post :auto_provision, params: { :id => host.id }
    assert_match(/Host #{host.name} was provisioned with rule #{rule.name}/, @response.body)
    managed_host = Host.unscoped.find(host.id)
    assert managed_host.build
    assert_response :success
  end

  def test_auto_provision_kexec_success
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.stubs(:kexec).returns(true)
    Host::Managed::any_instance.stubs(:provisioning_template).with(:kind => 'kexec').returns("")
    facts = @facts.merge({"somefact" => "abc", "discovery_kexec" => "kexec-tools 2.0.8 released 15 February 2015"})
    host = discover_host_from_facts(facts)
    taxonomy = { :organizations => [host.organization], :locations => [host.location] }
    rule = FactoryBot.create(:discovery_rule, {:priority => 1, :search => "facts.somefact = abc", :hostgroup => FactoryBot.create(:hostgroup, :with_os, :with_rootpass, taxonomy)}.merge(taxonomy))
    post :auto_provision, params: { :id => host.id }
    assert_match(/Host #{host.name} was provisioned with rule #{rule.name}/, @response.body)
    managed_host = Host.unscoped.find(host.id)
    assert managed_host.build
    assert_response :success
  end

  def test_auto_provision_with_wrong_org_or_loc_fail
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    taxonomy = { :organizations => [FactoryBot.create(:organization)], :locations => [FactoryBot.create(:location)] }
    FactoryBot.create(:discovery_rule, {:priority => 1, :search => "facts.somefact = abc", :hostgroup => FactoryBot.create(:hostgroup, :with_os, :with_rootpass, taxonomy)}.merge(taxonomy))
    post :auto_provision, params: { :id => host.id }
    show_response = ActiveSupport::JSON.decode(@response.body)
    assert_equal "No rule found for host #{host.name}", show_response["error"]["message"]
  end

  def test_auto_provision_success_and_delete
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    taxonomy = { :organizations => [host.organization], :locations => [host.location] }
    FactoryBot.create(:discovery_rule, {:priority => 1, :search => "facts.somefact = abc", :hostgroup => FactoryBot.create(:hostgroup, :with_os, :with_rootpass, taxonomy)}.merge(taxonomy))
    post :auto_provision, params: { :id => host.id }
    assert_response :success
    # test deletion of a managed host
    switch_controller(::Api::V2::HostsController) do
      delete :destroy, params: { :id => host.id }
      assert_match host.name, @response.body
      assert_response :success
    end
  end

  def test_auto_provision_no_rule_error
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    post :auto_provision, params: { :id => host.id }
    assert_response :not_found
    show_response = ActiveSupport::JSON.decode(@response.body)
    assert_equal "No rule found for host #{host.name}", show_response["error"]["message"]
  end

  def test_auto_provision_all_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    host = discover_host_from_facts(facts)
    taxonomy = { :organizations => [host.organization], :locations => [host.location] }
    FactoryBot.create(:discovery_rule, {:priority => 1, :search => "facts.somefact = abc", :hostgroup => FactoryBot.create(:hostgroup, :with_os, :with_rootpass, taxonomy)}.merge(taxonomy))
    post :auto_provision_all, params: {}
    assert_match(/1 discovered hosts were provisioned/, @response.body)
    managed_host = Host.unscoped.find(host.id)
    assert managed_host.build
    assert_response :success
  end

  def test_auto_provision_all_no_rule_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    discover_host_from_facts(facts)
    post :auto_provision_all, params: {}
    assert_match(/0 discovered hosts were provisioned/, @response.body)
    assert_response :success
  end

end
