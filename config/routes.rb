# All routes entered here will automatically be pulled in Foreman
Rails.application.routes.draw do

  scope :module => "ForemanDiscovery" do
    match 'discovered',     :to => 'discoveredhosts#discovered'
    match 'discovered/:id', :to => 'discoveredhosts#disc_show', :as => 'disc'
  end

end
