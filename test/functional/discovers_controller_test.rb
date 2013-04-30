require 'test_helper'
require 'mocha/setup'

class DiscoversControllerTest < ActionController::TestCase
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
    assert_tag :tag => 'div',
      :attributes => { :class => "nav-collapse collapse nav2" },
      :child => { :tag => 'ul',
        :child => { :tag => 'li',
          :child => { :tag => 'ul',
            :child => { :tag => 'li',
              :child => {
                :tag => 'a',
                :attributes => {:href => '/discovers'}
              }
            }
          }
        }
      }
  end

  private
  def initialize_host
    User.current = users(:admin)
  end
end
