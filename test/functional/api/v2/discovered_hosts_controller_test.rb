require 'test_helper'

class Api::V2::DiscoveredHostsControllerTest < ActionController::TestCase

  def switch_controller(klass)
    old_controller = @controller
    @controller = klass.new
    yield
    @controller = old_controller
  end

  setup do
    SETTINGS[:organizations_enabled] = true
    SETTINGS[:locations_enabled] = true
    FactoryGirl.create(:subnet, :network => "192.168.100.1", :mask => "255.255.255.0", :locations => [Location.first], :organizations => [Organization.first])
    User.current = User.find_by_login "admin"
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

  def setup_hostgroup(host)
    domain = FactoryGirl.create(:domain)
    hostgroup = FactoryGirl.create(:hostgroup, :with_subnet, :with_environment, :with_rootpass, :with_puppet_orchestration, :with_os, :domain => domain, :organizations => [host.organization], :locations => [host.location])
    hostgroup.medium.organizations << host.organization
    hostgroup.medium.locations << host.location
    hostgroup.ptable.organizations << host.organization
    hostgroup.ptable.locations << host.location
    hostgroup.domain.organizations << host.organization
    hostgroup.domain.locations << host.location
    hostgroup.subnet.organizations << host.organization
    hostgroup.subnet.locations << host.location
    hostgroup.environment.organizations << host.organization
    hostgroup.environment.locations << host.location
    hostgroup.puppet_proxy.organizations << host.organization
    hostgroup.puppet_proxy.locations << host.location
    hostgroup.puppet_ca_proxy.organizations << host.organization
    hostgroup.puppet_ca_proxy.locations << host.location
    domain.subnets << hostgroup.subnet
    hostgroup
  end

  def test_get_index
    get :index, { }
    assert_response :success
  end

  def test_show_host
    FactoryGirl.create(:organization, :name => 'SomeOrg')
    FactoryGirl.create(:location, :name => 'SomeLoc')
    host = Host::Discovered.import_host(@facts)
    get :show, { :id => host.id }
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
    host = Host::Discovered.import_host(@facts)
    delete :destroy, { :id => host.id }
    assert_response :success
  end

  def test_provision_host
    FactoryGirl.create(:organization, :name => 'SomeOrg')
    FactoryGirl.create(:location, :name => 'SomeLoc')
    host = Host::Discovered.import_host(@facts)
    hostgroup = setup_hostgroup(host)
    put :update,
        id: host.id,
        discovered_host: {
          hostgroup_id: hostgroup.id
        }

    assert_response :success

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

  def test_auto_provision_success_via_upload
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    FactoryGirl.create(:discovery_rule, :priority => 1, :name => 'rule', :search => "facts.somefact = abc",
                       :hostgroup => FactoryGirl.create(:hostgroup, :with_os, :with_rootpass), :organizations => [Organization.first],
                       :locations => [Location.first])
    post :facts, { :facts => facts }

    assert_response :success
    actual = JSON.parse(response.body)
    assert_not_nil actual['created_at']
    assert_equal "Auto-discovered and provisioned via rule 'rule'", Host.find(actual['id']).comment
  end

  def test_auto_provision_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc", "discovery_version" => "2.9.9"})
    host = Host::Discovered.import_host(facts)
    rule = FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc",
                       :hostgroup => FactoryGirl.create(:hostgroup, :with_os, :with_rootpass),
                       :organizations => [host.organization], :locations => [host.location])
    post :auto_provision, { :id => host.id }
    assert_match /Host #{host.name} was provisioned with rule #{rule.name}/, @response.body
    managed_host = Host.find(host.id)
    assert managed_host.build
    assert_response :success
  end

  def test_auto_provision_kexec_success
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.stubs(:kexec).returns(true)
    Host::Managed::any_instance.stubs(:provisioning_template).with(:kind => 'kexec').returns("")
    facts = @facts.merge({"somefact" => "abc", "discovery_kexec" => "kexec-tools 2.0.8 released 15 February 2015"})
    host = Host::Discovered.import_host(facts)
    rule = FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc",
                       :hostgroup => FactoryGirl.create(:hostgroup, :with_os, :with_rootpass),
                       :organizations => [host.organization], :locations => [host.location])
    post :auto_provision, { :id => host.id }
    assert_match /Host #{host.name} was provisioned with rule #{rule.name}/, @response.body
    managed_host = Host.find(host.id)
    assert managed_host.build
    assert_response :success
  end

  def test_auto_provision_with_wrong_org_or_loc_fail
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host(facts)
    FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc",
                       :hostgroup => FactoryGirl.create(:hostgroup, :with_os, :with_rootpass))
    post :auto_provision, { :id => host.id }
    show_response = ActiveSupport::JSON.decode(@response.body)
    assert_equal "No rule found for host #{host.name}", show_response["error"]["message"]
  end

  def test_auto_provision_with_wrong_disabled_org_sucess
    disable_orchestration
    SETTINGS[:organizations_enabled] = false
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host(facts)
    FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc",
                       :hostgroup => FactoryGirl.create(:hostgroup, :with_os, :with_rootpass),
                       :locations => [host.location])
    post :auto_provision, { :id => host.id }
    assert_match host.name, @response.body
    assert_response :success
  ensure
    SETTINGS[:organizations_enabled] = true
  end

  def test_auto_provision_success_and_delete
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host(facts)
    FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc",
                       :hostgroup => FactoryGirl.create(:hostgroup, :with_os, :with_rootpass),
                       :organizations => [host.organization], :locations => [host.location])
    post :auto_provision, { :id => host.id }
    assert_response :success
    # test deletion of a managed host
    switch_controller(::Api::V2::HostsController) do
      delete :destroy, { :id => host.id }
      assert_match host.name, @response.body
      assert_response :success
    end
  end

  def test_auto_provision_no_rule_error
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host(facts)
    post :auto_provision, { :id => host.id }
    assert_response :not_found
    show_response = ActiveSupport::JSON.decode(@response.body)
    assert_equal "No rule found for host #{host.name}", show_response["error"]["message"]
  end

  def test_auto_provision_all_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host(facts)
    FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc",
                       :hostgroup => FactoryGirl.create(:hostgroup, :with_os, :with_rootpass), :organizations => [host.organization],
                       :locations => [host.location])
    post :auto_provision_all, {}
    assert_match /1 discovered hosts were provisioned/, @response.body
    managed_host = Host.find(host.id)
    assert managed_host.build
    assert_response :success
  end

  def test_auto_provision_all_no_rule_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    Host::Discovered.import_host(facts)
    post :auto_provision_all, {}
    assert_match /0 discovered hosts were provisioned/, @response.body
    assert_response :success
  end

end
