def set_session_user(user)
  SETTINGS[:login] ? {:user => user.id, :expires_at => 5.minutes.from_now} : {}
end

def user_with_perms(perms)
  perms = perms.collect{|p| Permission.find_by_name(p) || Permission.create(:name => p) }
  perms.each do |p|
    p.resource_type = 'Host' if p.name =~ /discovered_hosts$/
    p.resource_type = 'DiscoveryRule' if p.name =~ /discovery_rules$/
    p.save!
  end
  role = FactoryBot.create :role
  perms.each do |perm|
    FactoryBot.create(:filter, :role => role, :permissions => [perm])
  end
  user = FactoryBot.create :user, :with_mail, :admin => false
  user.roles << role
  user.save
  user
end

def as_default_manager
  as_user(default_manager) do
    yield
  end
end

def as_default_reader
  as_user(default_reader) do
    yield
  end
end

def default_manager
  @default_manager ||= user_with_perms(Foreman::Plugin.find('foreman_discovery').default_roles['Discovery Manager'])
end

def default_reader
  @default_reader ||= user_with_perms(Foreman::Plugin.find('foreman_discovery').default_roles['Discovery Reader'])
end

def set_session_user_default_reader
  set_session_user(default_reader)
end

def set_session_user_default_manager
  set_session_user(default_manager)
end

def extract_form_errors(response)
  response.body.scan(/error-message[^<]*</)
end

def set_default_settings
  FactoryBot.create(:setting, :name => 'discovery_fact', :value => 'discovery_bootif', :category => 'Setting::Discovered')
  FactoryBot.create(:setting, :name => 'discovery_hostname', :value => 'discovery_bootif', :category => 'Setting::Discovered')
  FactoryBot.create(:setting, :name => 'discovery_auto', :value => true, :category => 'Setting::Discovered')
  FactoryBot.create(:setting, :name => 'discovery_reboot', :value => true, :category => 'Setting::Discovered')
  FactoryBot.create(:setting, :name => 'discovery_organization', :value => "Organization 1", :category => 'Setting::Discovered')
  FactoryBot.create(:setting, :name => 'discovery_location', :value => "Location 1", :category => 'Setting::Discovered')
  FactoryBot.create(:setting, :name => 'discovery_prefix', :value => 'mac', :category => 'Setting::Discovered')
  FactoryBot.create(:setting, :name => 'discovery_clean_facts', :value => false, :category => 'Setting::Discovered')
  FactoryBot.create(:setting, :name => 'discovery_lock', :value => 'false', :category => 'Setting::Discovered')
  FactoryBot.create(:setting, :name => 'discovery_lock_template', :value => 'pxelinux_discovery', :category => 'Setting::Discovered')
  FactoryBot.create(:setting, :name => 'discovery_pxelinux_lock_template', :value => 'pxelinux_discovery', :category => 'Setting::Discovered')
  FactoryBot.create(:setting, :name => 'discovery_pxegrub_lock_template', :value => 'pxegrub_discovery', :category => 'Setting::Discovered')
  FactoryBot.create(:setting, :name => 'discovery_pxegrub2_lock_template', :value => 'pxegrub2_discovery', :category => 'Setting::Discovered')
  FactoryBot.create(:setting, :name => 'discovery_always_rebuild_dns', :value => true, :category => 'Setting::Discovered')
end

def setup_hostgroup(host)
  domain = FactoryBot.create(:domain)
  subnet = FactoryBot.create(:subnet_ipv4, :network => "192.168.100.0")
  environment = FactoryBot.create(:environment, :organizations => [host.organization], :locations => [host.location])
  medium = FactoryBot.create(:medium, :organizations => [host.organization], :locations => [host.location])
  os = FactoryBot.create(:operatingsystem, :with_ptables, :with_archs, :media => [medium])
  hostgroup = FactoryBot.create(
    :hostgroup, :with_rootpass, :with_puppet_orchestration,
    :operatingsystem => os,
    :architecture => os.architectures.first,
    :ptable => os.ptables.first,
    :medium => os.media.first,
    :environment => environment,
    :subnet => subnet,
    :domain => domain,
    :organizations => [host.organization], :locations => [host.location])
  domain.subnets << hostgroup.subnet
  hostgroup.medium.organizations |= [host.organization]
  hostgroup.medium.locations |= [host.location]
  hostgroup.ptable.organizations |= [host.organization]
  hostgroup.ptable.locations |= [host.location]
  hostgroup.domain.organizations |= [host.organization]
  hostgroup.domain.locations |= [host.location]
  hostgroup.subnet.organizations |= [host.organization]
  hostgroup.subnet.locations |= [host.location]
  hostgroup.environment.organizations |= [host.organization]
  hostgroup.environment.locations |= [host.location]
  hostgroup.puppet_proxy.organizations |= [host.organization]
  hostgroup.puppet_proxy.locations |= [host.location]
  hostgroup.puppet_ca_proxy.organizations |= [host.organization]
  hostgroup.puppet_ca_proxy.locations |= [host.location]
  hostgroup
end

def organization_one
  Organization.find_by_name('Organization 1')
end

def location_one
  Location.find_by_name('Location 1')
end

def current_path_info
  current_url.sub(%r{.*?://}, '')[%r{[/\?\#].*}] || '/'
end

def current_params
  query = current_path_info.split('?')[1]
  Rack::Utils.parse_nested_query query
end

def facts_simple_network100_42
  {
    "interfaces"       => "lo,eth0,eth1",
    "ipaddress"        => "192.168.100.42",
    "ipaddress_eth0"   => "192.168.100.42",
    "ipaddress_eth1"   => "192.168.100.15",
    "macaddress_eth0"  => "AA:BB:CC:DD:EE:FF",
    "macaddress_eth1"  => "AA:BB:CC:DD:EE:F1",
    "discovery_bootif" => "AA:BB:CC:DD:EE:FF",
  }
end

def discover_host_from_facts(facts)
  User.as_anonymous_admin do
    Host::Discovered.import_host(facts)
  end
end

def assert_param(expected, param)
  keys = param.split('.')
  result = current_params
  keys.each do |key|
    result = result[key]
  end
  assert_equal expected, result
end

def assert_selected(select_selector, value)
  select = page.all(select_selector, visible: false).last
  selected = select.find("option[selected='selected']", visible: false) rescue nil
  assert_not_nil selected, "Nothing selected in #{select_selector}"
  assert_equal value.to_s, selected.value
end

def discovered_notification_blueprint
  @blueprint ||= FactoryBot.create(:notification_blueprint,
                                   name: 'new_discovered_host')
end
