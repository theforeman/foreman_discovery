# All routes entered here will automatically be pulled in Foreman
Rails.application.routes.draw do

  #Example
  match 'discovered', :to => 'foreman_discovery/hosts#discovered'

end
