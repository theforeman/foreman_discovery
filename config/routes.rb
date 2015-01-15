# All routes entered here will automatically be pulled in Foreman
Rails.application.routes.draw do

  # Needed to make the hosts/edit form render
  match 'architecture_selected_discovered_hosts' => 'hosts#architecture_selected'
  match 'os_selected_discovered_hosts'           => 'hosts#os_selected'
  match 'medium_selected_discovered_hosts'       => 'hosts#medium_selected'

  constraints(:id => /[^\/]+/) do
    resources :discovered_hosts do
      member do
        get 'refresh_facts'
        put 'reboot'
        post 'auto_provision'
      end
      collection do
        get 'multiple_destroy'
        post 'submit_multiple_destroy'
        get  'select_multiple_organization'
        post 'update_multiple_organization'
        get  'select_multiple_location'
        post 'update_multiple_location'
        get  'auto_complete_search'
        get 'auto_provision_all'
        post 'submit_auto_provision_all'
      end
    end
  end

  resources :discovery_rules, :except => [:show] do
    member do
      get :enable
      get :disable
    end
  end

  ## API
  namespace :api, :defaults => {:format => 'json'} do
    scope "(:apiv)", :module => :v2, :defaults => {:apiv => 'v2'}, :apiv => /v1|v2/, :constraints => ApiConstraints.new(:version => 2) do
      resources :discovered_hosts, :except => [:new, :edit] do
        member do
          post 'auto_provision'
          put 'reboot'
        end
        collection do
          post 'facts'
          post 'auto_provision_all'
        end
        member do
          put 'refresh_facts'
        end
      end
      resources :discovery_rules, :except => [:new, :edit]
    end
  end

end
