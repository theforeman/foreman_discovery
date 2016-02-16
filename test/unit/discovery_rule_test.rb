require 'test_helper'

class DiscoveryRuleTest < ActiveSupport::TestCase
  setup do
    @hg_org = FactoryGirl.create(:organization, :name => 'hgorg')
    @hg_org.save!
    @hostgroup = FactoryGirl.create(:hostgroup)
    @hostgroup.organizations << @hg_org
    @hostgroup.save!
  end

  test "should be able to create a rule without entering hosts limit" do
    rule = DiscoveryRule.new :name => "myrule",
      :search => "cpu_count > 1",
      :priority => "1",
      :hostgroup_id => @hostgroup.id,
      :organization_ids => [@hg_org.id]
    assert_valid rule
  end

  test "should be able to create a rule without entering priority" do
    rule = DiscoveryRule.new :name => "myrule",
      :search => "cpu_count > 1",
      :max_count => "1",
      :hostgroup_id => @hostgroup.id,
      :organization_ids => [@hg_org.id]
    assert_valid rule
  end

  test "should not be able to create a rule without a hostgroup" do
    rule = DiscoveryRule.new :name => "myrule",
      :search => "cpu_count > 1",
      :organization_ids => [@hg_org.id]
    refute_valid rule
    assert_equal "can't be blank", rule.errors[:hostgroup_id].first
  end

  test "should not be able to create a rule with priority bigger than 2^31" do
    rule = DiscoveryRule.new :name => "myrule",
      :search => "cpu_count > 1",
      :priority => 2**31 + 1,
      :hostgroup_id => @hostgroup.id,
      :organization_ids => [@hg_org.id]
    refute_valid rule
    assert_equal "must be less than 2147483648", rule.errors[:priority].first
  end

  test "should not be able to create a rule with max count bigger than 2^31" do
    rule = DiscoveryRule.new :name => "myrule",
      :search => "cpu_count > 1",
      :max_count => 2**31 + 1,
      :hostgroup_id => @hostgroup.id,
      :organization_ids => [@hg_org.id]
    refute_valid rule
    assert_equal "must be less than 2147483648", rule.errors[:max_count].first
  end

  test "should enforce hostgroup organizations" do
    skip unless SETTINGS[:organizations_enabled]
    rule = DiscoveryRule.new :name => "myrule",
      :search => "cpu_count > 1",
      :hostgroup_id => @hostgroup.id
    refute_valid rule
    assert_equal "Host group organization #{@hg_org.name} must also be associated to the discovery rule", rule.errors[:organizations].first
  end

  test "should enforce hostgroup organizations and locations" do
    skip unless (SETTINGS[:organizations_enabled] && SETTINGS[:locations_enabled])
    loc = FactoryGirl.create(:location, :name => "hgloc")
    @hostgroup.locations << loc
    @hostgroup.save!
    rule = DiscoveryRule.new :name => "myrule",
      :search => "cpu_count > 1",
      :hostgroup_id => @hostgroup.id,
      :organization_ids => [@hg_org.id]
    refute_valid rule
    assert_equal "Host group location #{loc.name} must also be associated to the discovery rule", rule.errors[:locations].first
  end
end
