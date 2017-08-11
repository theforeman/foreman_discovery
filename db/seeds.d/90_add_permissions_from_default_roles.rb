# frozen_string_literal: true
default_permissions = Foreman::Plugin.find("foreman_discovery").default_roles

["Discovery Reader", "Discovery Manager"].each do |role_name|
  Role.ignore_locking do
    role = Role.unscoped.find_by_name(role_name) || next
    default_permissions[role_name].each do |permission|
      role.add_permissions(permission) unless role.permission_names.include?(permission.to_sym)
    end
    role.origin = 'discovery'
    role.description = 'Discovery plugin built-in role'
    role.save
  end
end
