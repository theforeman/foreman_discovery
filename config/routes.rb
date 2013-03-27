# All routes entered here will automatically be pulled in Foreman
Rails.application.routes.draw do

  scope :module => "foreman_discovery" do
    constraints(:id => /[^\/]+/) do
      resources :discovered
      match 'discovered/:id/refresh_facts' => 'discovered#refresh_facts', :as => 'refresh_facts'
      match 'architecture_selected_discovered' => 'hosts#architecture_selected'
      match 'os_selected_discovered' => 'hosts#os_selected'
      match 'medium_selected_discovered' => 'hosts#medium_selected'
    end
  end

end
