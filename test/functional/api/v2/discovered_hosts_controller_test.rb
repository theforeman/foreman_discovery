require 'test_helper'

class Api::V2::DiscoveredHostsControllerTest < ActionController::TestCase

  def switch_controller(klass)
    old_controller = @controller
    @controller = klass.new
    yield
    @controller = old_controller
  end

  setup do
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
    FactoryGirl.create(:setting,
                       :name => 'discovery_auto',
                       :value => true,
                       :category => 'Setting::Discovered')
    FactoryGirl.create(:setting,
                       :name => 'discovery_reboot',
                       :value => true,
                       :category => 'Setting::Discovered')
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.stubs(:reboot).returns(true)
  end

  def test_get_index
    get :index, { }
    assert_response :success
  end

  def test_show_host
    SETTINGS[:organizations_enabled] = true
    SETTINGS[:locations_enabled] = true
    FactoryGirl.create(:organization, :name => 'SomeOrg')
    FactoryGirl.create(:location, :name => 'SomeLoc')
    FactoryGirl.create(:setting,
                       :name => 'discovery_organization',
                       :value => 'SomeOrg',
                       :category => 'Setting::Discovered')
    FactoryGirl.create(:setting,
                       :name => 'discovery_location',
                       :value => 'SomeLoc',
                       :category => 'Setting::Discovered')
    host = Host::Discovered.import_host_and_facts(@facts).first
    get :show, { :id => host.id }
    assert_response :success
    show_response = ActiveSupport::JSON.decode(@response.body)
    assert_equal "macaabbccddeeff", show_response["name"]
    assert_equal 42001, show_response["memory"]
    assert_equal 0, show_response["disk_count"]
    assert_equal 0, show_response["disks_size"]
    assert_equal 'SomeOrg', show_response["organization_name"]
    assert_equal 'SomeLoc', show_response["location_name"]
  end

  def test_delete_discovered_host
    host = Host::Discovered.import_host_and_facts(@facts).first
    delete :destroy, { :id => host.id }
    assert_response :success
  end

  def test_auto_provision_success_via_upload
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    FactoryGirl.create(:discovery_rule, :priority => 1, :name => 'rule', :search => "facts.somefact = abc",
                       :hostgroup => FactoryGirl.create(:hostgroup, :with_os, :with_rootpass), :organizations => [Organization.first],
                       :locations => [Location.first])
    post :facts, { :facts => facts }
    assert_response :success
    assert_equal "Auto-discovered and provisioned via rule 'rule'", Host.first.comment
  end

  def test_auto_provision_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc", "discovery_version" => "2.9.9"})
    host = Host::Discovered.import_host_and_facts(facts).first
    rule = FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc",
                       :hostgroup => FactoryGirl.create(:hostgroup, :with_os, :with_rootpass),
                       :organizations => [host.organization], :locations => [host.location])
    post :auto_provision, { :id => host.id }
    assert_match /Host #{host.name} was provisioned with rule #{rule.name}/, @response.body
    assert_response :success
  end

  def test_auto_provision_kexec_success
    ::ForemanDiscovery::NodeAPI::PowerService.any_instance.stubs(:kexec).returns(true)
    Host::Managed::any_instance.stubs(:provisioning_template).with(:kind => 'kexec').returns("")
    facts = @facts.merge({"somefact" => "abc", "discovery_kexec" => "kexec-tools 2.0.8 released 15 February 2015"})
    host = Host::Discovered.import_host_and_facts(facts).first
    rule = FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc",
                       :hostgroup => FactoryGirl.create(:hostgroup, :with_os, :with_rootpass),
                       :organizations => [host.organization], :locations => [host.location])
    post :auto_provision, { :id => host.id }
    assert_match /Host #{host.name} was provisioned with rule #{rule.name}/, @response.body
    assert_response :success
  end

  def test_auto_provision_with_wrong_org_or_loc_fail
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host_and_facts(facts).first
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
    host = Host::Discovered.import_host_and_facts(facts).first
    FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc",
                       :hostgroup => FactoryGirl.create(:hostgroup, :with_os, :with_rootpass),
                       :locations => [host.location])
    post :auto_provision, { :id => host.id }
    assert_match host.name, @response.body
    assert_response :success
  end

  def test_auto_provision_success_and_delete
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host_and_facts(facts).first
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
    host = Host::Discovered.import_host_and_facts(facts).first
    post :auto_provision, { :id => host.id }
    assert_response :not_found
    show_response = ActiveSupport::JSON.decode(@response.body)
    assert_equal "No rule found for host #{host.name}", show_response["error"]["message"]
  end

  def test_auto_provision_all_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    host = Host::Discovered.import_host_and_facts(facts).first
    FactoryGirl.create(:discovery_rule, :priority => 1, :search => "facts.somefact = abc",
                       :hostgroup => FactoryGirl.create(:hostgroup, :with_os, :with_rootpass), :organizations => [host.organization],
                       :locations => [host.location])
    post :auto_provision_all, {}
    assert_match /1 discovered hosts were provisioned/, @response.body
    assert_response :success
  end

  def test_auto_provision_all_no_rule_success
    disable_orchestration
    facts = @facts.merge({"somefact" => "abc"})
    Host::Discovered.import_host_and_facts(facts).first
    post :auto_provision_all, {}
    assert_match /0 discovered hosts were provisioned/, @response.body
    assert_response :success
  end

end

