# All routes entered here will automatically be pulled in Foreman
Rails.application.routes.draw do

  #Example
  match 'discovered',     :to => 'hosts#discovered'
  match 'discovered/:id', :to => 'hosts#disc_show', :as => 'disc_host'

end
