# All routes entered here will automatically be pulled in Foreman
Rails.application.routes.draw do

  # Needed to make the hosts/edit form render
  post 'architecture_selected_discovered_hosts' => 'hosts#architecture_selected'
  post 'os_selected_discovered_hosts'           => 'hosts#os_selected'
  post 'medium_selected_discovered_hosts'       => 'hosts#medium_selected'

  get 'discovered_hosts/help', :action => :welcome, :controller => 'discovered_hosts'
  get 'discovery_rules/help', :action => :welcome, :controller => 'discovery_rules'

  constraints(:id => /[^\/]+/) do
    resources :discovered_hosts, :except => [:new, :create] do
      member do
        get 'refresh_facts'
        put 'reboot'
        post 'auto_provision'
      end
      collection do
        get  'auto_complete_search'
        put  'submit_multiple_reboot'
        put  'submit_multiple_auto_provision'
        post 'multiple_destroy'
        post 'submit_multiple_destroy'
        post 'select_multiple_organization'
        post 'update_multiple_organization'
        post 'select_multiple_location'
        post 'update_multiple_location'
        post 'multiple_reboot'
        post 'multiple_auto_provision'
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
          put 'refresh_facts'
        end
        collection do
          post 'facts'
          post 'auto_provision_all'
          put  'reboot_all'
        end

        constraints(:discovered_host_id => /[^\/]+/) do
          resources :facts, :only => :index, :controller => :fact_values
        end
      end
      resources :discovery_rules, :except => [:new, :edit]
    end
  end

end
