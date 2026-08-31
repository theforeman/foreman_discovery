require_relative '../../../test_plugin_helper'

module ForemanDiscovery
  module Concerns
    class HostsControllerTest < ActionController::TestCase
      tests ::HostsController

      context 'hosts controller requests from discovered_hosts url' do
        test 'get "host" params from "discovered_hosts" params' do
          os = FactoryBot.create(:operatingsystem, :with_associations)
          arch_id = os.architectures.first.id
          discovered_host_params = {
            'discovered_host' => { 'architecture_id' => arch_id }
          }

          @request.stubs(:path).returns(architecture_selected_discovered_hosts_path)
          post :architecture_selected, params: discovered_host_params, session: set_session_user
          assert_match(/"#{os.id}"/, response.body)
        end
      end

      describe 'template_used' do
        include FactImporterIsolation
        allow_transactions_for_any_importer

        setup do
          @facts = {
            "interfaces" => "lo,eth0",
            "ipaddress" => "192.168.100.42",
            "ipaddress_eth0" => "192.168.100.42",
            "macaddress_eth0" => "AA:BB:CC:DD:EE:FF",
            "discovery_bootif" => "AA:BB:CC:DD:EE:FF",
            "physicalprocessorcount" => "42",
            "discovery_version" => "3.0.0",
          }
        end

        test 'converts the discovered host to a managed host' do
          host = discover_host_from_facts(@facts)
          params = {
            id: host.id,
            host: {
              architecture_id: architectures(:x86_64).id, # rubocop:disable Naming/VariableNumber
              operatingsystem_id: operatingsystems(:redhat).id,
            }
          }
          get :template_used, params: params, session: set_session_user

          assert_response :success
          assert_instance_of Host::Managed, assigns(:host)
        end
      end

      describe 'find_resource' do
        include FactImporterIsolation
        allow_transactions_for_any_importer

        setup do
          @facts = {
            "interfaces" => "lo,eth0",
            "ipaddress" => "192.168.100.42",
            "ipaddress_eth0" => "192.168.100.42",
            "macaddress_eth0" => "AA:BB:CC:DD:EE:FF",
            "discovery_bootif" => "AA:BB:CC:DD:EE:FF",
            "physicalprocessorcount" => "42",
            "discovery_version" => "3.0.0",
          }
        end

        test 'finds a discovered host directly without converting it' do
          host = discover_host_from_facts(@facts)
          get :build_errors, params: { id: host.id }, session: set_session_user

          assert_response :success
          assert_instance_of Host::Discovered, assigns(:host)
          assert_equal host, assigns(:host)
        end

        test 'falls back to the core lookup for a managed host' do
          host = FactoryBot.create(:host, :managed)
          get :build_errors, params: { id: host.id }, session: set_session_user

          assert_response :success
          assert_instance_of Host::Managed, assigns(:host)
          assert_equal host, assigns(:host)
        end

        test 'renders not found for an unknown host id' do
          get :build_errors, params: { id: 0 }, session: set_session_user

          assert_response :not_found
        end
      end
    end
  end
end
