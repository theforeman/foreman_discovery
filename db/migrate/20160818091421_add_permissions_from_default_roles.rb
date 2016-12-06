class AddPermissionsFromDefaultRoles < ActiveRecord::Migration
  def up
    default_permissions = Foreman::Plugin.find("foreman_discovery").default_roles
    ["Discovery Reader", "Discovery Manager"].each do |role_name|
      role = Role.find_by_name(role_name) || next
      default_permissions[role_name].each do |permission|
        role.add_permissions!(permission) unless role.permission_names.include?(permission.to_sym)
      end
    end
  end

  def down
    # not implemented
  end
end
