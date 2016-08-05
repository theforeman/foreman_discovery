def set_session_user_with_perms perms
  perms = perms.collect{|p| Permission.find_by_name(p) || Permission.create(:name => p) }
  perms.each do |p|
    p.resource_type = 'Host' if p.name =~ /discovered_hosts$/
    p.resource_type = 'DiscoveryRule' if p.name =~ /discovery_rules$/
    p.save!
  end
  role = FactoryGirl.create :role
  perms.each do |perm|
    FactoryGirl.create(:filter, :role => role, :permissions => [perm])
  end
  user = FactoryGirl.create :user, :with_mail, :admin => false
  user.roles << role
  user.save!
  SETTINGS[:login] ? {:user => user.id, :expires_at => 5.minutes.from_now} : {}
end

def set_session_user_default_reader
  set_session_user_with_perms Foreman::Plugin.find('foreman_discovery').default_roles['Discovery Reader']
end

def set_session_user_default_manager
  set_session_user_with_perms Foreman::Plugin.find('foreman_discovery').default_roles['Discovery Manager']
end

def extract_form_errors(response)
  response.body.scan(/error-message[^<]*</)
end

def set_default_settings
  FactoryGirl.create(:setting, :name => 'discovery_fact', :value => 'discovery_bootif', :category => 'Setting::Discovered')
  FactoryGirl.create(:setting, :name => 'discovery_hostname', :value => 'discovery_bootif', :category => 'Setting::Discovered')
  FactoryGirl.create(:setting, :name => 'discovery_auto', :value => true, :category => 'Setting::Discovered')
  FactoryGirl.create(:setting, :name => 'discovery_reboot', :value => true, :category => 'Setting::Discovered')
  FactoryGirl.create(:setting, :name => 'discovery_organization', :value => Organization.first.name, :category => 'Setting::Discovered')
  FactoryGirl.create(:setting, :name => 'discovery_location', :value => Location.first.name, :category => 'Setting::Discovered')
  FactoryGirl.create(:setting, :name => 'discovery_prefix', :value => 'mac', :category => 'Setting::Discovered')
  FactoryGirl.create(:setting, :name => 'discovery_clean_facts', :value => false, :category => 'Setting::Discovered')
  FactoryGirl.create(:setting, :name => 'discovery_lock', :value => 'false', :category => 'Setting::Discovered')
  FactoryGirl.create(:setting, :name => 'discovery_lock_template', :value => 'pxelinux_discovery', :category => 'Setting::Discovered')
  FactoryGirl.create(:setting, :name => 'discovery_pxelinux_lock_template', :value => 'pxelinux_discovery', :category => 'Setting::Discovered')
  FactoryGirl.create(:setting, :name => 'discovery_pxegrub_lock_template', :value => 'pxegrub_discovery', :category => 'Setting::Discovered')
  FactoryGirl.create(:setting, :name => 'discovery_pxegrub2_lock_template', :value => 'pxegrub2_discovery', :category => 'Setting::Discovered')
  FactoryGirl.create(:setting, :name => 'discovery_always_rebuild_dns', :value => true, :category => 'Setting::Discovered')
end
