# All routes entered here will automatically be pulled in Foreman
Rails.application.routes.draw do

  # Needed to make the hosts/edit form render
  match 'architecture_selected_discovers' => 'hosts#architecture_selected'
  match 'os_selected_discovers'           => 'hosts#os_selected'
  match 'medium_selected_discovers'       => 'hosts#medium_selected'

  constraints(:id => /[^\/]+/) do
    resources :discovers do
      member do
        get 'refresh_facts'
      end
      collection do
        get 'multiple_destroy'
        post 'submit_multiple_destroy'
        get  'select_multiple_organization'
        post 'update_multiple_organization'
        get  'select_multiple_location'
        post 'update_multiple_location'
        get  'auto_complete_search'
      end
    end
  end

  ## API
  namespace :api, :defaults => {:format => 'json'} do
    scope "(:apiv)", :module => :v2, :defaults => {:apiv => 'v2'}, :apiv => /v1|v2/, :constraints => ApiConstraints.new(:version => 2) do
      resources :discovers do
        collection do
          post 'facts'
        end
      end
    end
  end

end
