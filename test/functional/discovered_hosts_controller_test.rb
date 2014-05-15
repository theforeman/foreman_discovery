require 'test_plugin_helper'

class DiscoveredHostsControllerTest < ActionController::TestCase
  setup :initialize_host

  def test_index
    get :index, {}, set_session_user
    assert_response :success
  end

  def test_index_json
    get :index, {:format => "json"}, set_session_user
    domain = ActiveSupport::JSON.decode(@response.body)
    assert_response :success
  end

  def test_add_entry_to_nav_menu
    get :index, {}, set_session_user
    assert_tag :tag => 'a',
      :attributes => {:href => '/discovered_hosts'}
  end

  private
  def initialize_host
    User.current = users(:admin)
  end
end
