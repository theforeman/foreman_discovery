# Add permissions
Foreman::AccessControl.map do |map|
  map.security_block :discovery do |map|
    map.permission :perform_discovery, {:discovers => [:index, :show, :update, :new,
      :edit, :destroy, :create, :auto_complete_search, :select_multiple_organization,
      :update_multiple_organization, :select_multiple_location, :refresh_facts,
      :update_multiple_location, :submit_multiple_destroy, :multiple_destroy]}
  end
end

# Add a new role called 'Discovery' if it doesn't exist
Role.transaction do
  discovery_role = Role.find_or_create_by_name("Discovery")
  if discovery_role.permissions.empty?
    discovery_role.update_attribute :permissions, [:perform_discovery]
  end
end
