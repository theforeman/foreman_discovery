require 'test_helper'

class DiscoveryRuleTest < ActiveSupport::TestCase
  setup do
    @hg_org = FactoryGirl.create(:organization, :name => 'hgorg')
    @hg_org.save!
    @hostgroup = FactoryGirl.create(:hostgroup)
    @hostgroup.organizations << @hg_org
    @hostgroup.save!
  end

  context "#validates attribute" do
    setup do
      @huge_name = "x" * 256
      @rule = DiscoveryRule.new :name => "myrule",
                               :search => "cpu_count > 1",
                               :priority => "1",
                               :hostgroup_id => @hostgroup.id,
                               :organization_ids => [@hg_org.id]
    end

    context "name" do
      test "max length is 255 characters" do
        @rule.name = @huge_name
        assert @rule.invalid?
        assert_equal "is too long (maximum is 255 characters)", @rule.errors[:name].first
      end

      test "can't have whitespace(s)" do
        @rule.name = "my rule"
        assert @rule.invalid?
        assert_equal "can't contain white spaces.", @rule.errors[:name].first
      end
    end

    context "search" do
      test "max length is 255 characters" do
        @rule.search = @huge_name
        assert @rule.invalid?
        assert_equal "is too long (maximum is 255 characters)", @rule.errors[:search].first
      end
    end

    context "hostname" do
      test "max length is 255 characters" do
        @rule.hostname = "abc" +  @huge_name
        assert @rule.invalid?
        assert_equal "is too long (maximum is 255 characters)", @rule.errors[:hostname].first
      end

      test "must start with a letter or ERB" do
        @rule.hostname = "123"
        assert @rule.invalid?
        assert_equal "must start with a letter or ERB.", @rule.errors[:hostname].first

        @rule.hostname = "<%= host.hostname %>"
        assert @rule.valid?
        assert @rule.errors.blank?
      end
    end
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
