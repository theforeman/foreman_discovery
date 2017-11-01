require 'test_plugin_helper'

module Api
  module V2
    class FactValuesControllerExtensionsTest < ActionController::TestCase
      tests Api::V2::FactValuesController

      setup do
        User.current = users(:admin)
        @facts       = {
            "interfaces"        => "lo,eth0",
            "ipaddress"         => "192.168.100.42",
            "ipaddress_eth0"    => "192.168.100.42",
            "macaddress_eth0"   => "AA:BB:CC:DD:EE:FF",
            "discovery_bootif"  => "AA:BB:CC:DD:EE:FF",
            "memorysize_mb"     => "42000.42",
            "discovery_version" => "3.0.0",
        }
        FactoryBot.create(:setting,
                           :name     => 'discovery_hostname',
                           :value    => 'discovery_bootif',
                           :category => 'Setting::Discovered')
      end


      test 'list discovered host facts' do
        disable_orchestration
        facts = @facts.merge({ "somefact" => "abc" })
        host = discover_host_from_facts(facts)
        get :index, { :host_id => host.id }
        assert_response :success
        show_response = ActiveSupport::JSON.decode(@response.body)
        assert_equal "abc", show_response['results'].values.first['somefact']
      end
    end
  end
end
