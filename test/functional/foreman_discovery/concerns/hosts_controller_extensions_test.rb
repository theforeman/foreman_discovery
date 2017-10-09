require 'test_plugin_helper'

module ForemanDiscovery
  module Concerns
    class HostsControllerTest < ActionController::TestCase
      tests ::HostsController

      context 'hosts controller requests from discovered_hosts url' do
        test 'get "host" params from "discovered_hosts" params' do
          os = FactoryGirl.create(:operatingsystem, :with_associations)
          arch_id = os.architectures.first.id
          discovered_host_params = {
            'discovered_host' => { 'architecture_id' => arch_id }
          }

          @request.stubs(:path).returns(architecture_selected_discovered_hosts_path)
          post :architecture_selected, discovered_host_params, set_session_user
          assert_match(/"#{os.id}"/, response.body)
        end
      end
    end
  end
end
