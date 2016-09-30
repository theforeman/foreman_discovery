require 'test_plugin_helper'
require 'test_helper_discovery'

module ForemanDiscovery
  module Concerns
    class HostsControllerTest < ActionController::TestCase
      tests ::HostsController

      context 'hosts controller requests from discovered_hosts url' do
        test 'get "host" params from "discovered_hosts" params' do
          architecture = FactoryGirl.create(:architecture)
          discovered_host_params = {
            'discovered_host' => { 'architecture_id' => architecture.id }
          }

          @request.stubs(:path).
            returns(architecture_selected_discovered_hosts_path)

          post :architecture_selected, discovered_host_params, set_session_user
          assert assigns('architecture'), architecture
        end
      end
    end
  end
end
