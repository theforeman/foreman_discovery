# All routes entered here will automatically be pulled in Foreman
Rails.application.routes.draw do

  scope :module => "ForemanDiscovery" do
    resources :discovered
    match 'discovered/:id/convert'       => 'discoveredhosts#convert',       :as => 'disc_convert'
    match 'discovered/:id/refresh_facts' => 'discoveredhosts#refresh_facts', :as => 'refresh_facts'
  end

end
