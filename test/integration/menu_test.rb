require 'test_helper'

class ManagedExtensionsTest < ActiveSupport::TestCase
  def test_discovery_rules_is_in_menu
    menu = UserMenu.new.generate
    assert_includes(menu, { name: 'Discovery Rules', url: '/discovery_rules' })
  end
end
