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
  SETTINGS[:login] ? {:user => user, :expires_at => 5.minutes.from_now} : {}
end

def set_session_user_default_reader
  set_session_user_with_perms Foreman::Plugin.find('foreman_discovery').default_roles['Discovery Reader']
end

def set_session_user_default_manager
  set_session_user_with_perms Foreman::Plugin.find('foreman_discovery').default_roles['Discovery Manager']
end
