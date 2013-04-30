# Add permissions
Foreman::AccessControl.map do |map|
  map.security_block :discovery do |map|
    map.permission :perform_discovery, {:discovers => [:index, :show, :update, :new,
      :edit, :destroy, :create, :auto_complete_search, :select_multiple_organization,
      :update_multiple_organization, :select_multiple_location, :refresh_facts,
      :update_multiple_location, :submit_multiple_destroy, :multiple_destroy]}
  end
end

begin
  # Add a new role called 'Discovery' if it doesn't exist
  Role.transaction do
    role = Role.find_or_create_by_name("Discovery")
    role.update_attribute :permissions, [:perform_discovery] if role.permissions.empty?
  end
rescue
end
