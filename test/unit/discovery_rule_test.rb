require 'test_helper'

class DiscoveryRuleTest < ActiveSupport::TestCase

  test "should be able to create a rule without entering hosts limit" do
    rule = DiscoveryRule.new :name => "myrule", :search => "cpu_count > 1", :priority => "1", :hostgroup_id => "1"
    assert_valid rule
  end

  test "should be able to create a rule without entering priority" do
    rule = DiscoveryRule.new :name => "myrule", :search => "cpu_count > 1", :max_count => "1", :hostgroup_id => "1"
    assert_valid rule
  end

  test "should not be able to create a rule without a hostgroup" do
    rule = DiscoveryRule.new :name => "myrule", :search => "cpu_count > 1"
    refute_valid rule
  end

end
