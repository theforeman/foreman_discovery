require 'test_plugin_helper'

class DiscoveryRuleTest < ActiveSupport::TestCase
  setup do
    @hostgroup = FactoryBot.create(:hostgroup)
  end

  should allow_values(*valid_name_list).for(:name)
  should_not allow_values(*invalid_name_list).for(:name)

  context "#validates attribute" do
    setup do
      @huge_name = "x" * 256
      @rule = DiscoveryRule.new :name => "myrule", :search => "cpu_count > 1", :priority => "1", :hostgroup_id => @hostgroup.id, :organization_ids => [organization_one.id], :location_ids => [location_one.id]
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

  test_attributes :pid => 'b8ae7a80-b9a8-4924-808c-482a2b4102c4'
  test "should create discovery rule with name and minimum required attributes" do
    rule = DiscoveryRule.new(:name => 'new_rule', :search => 'cpu_count = 1', :hostgroup_id => hostgroups(:unusual).id)
    assert_valid rule
  end

  test "should be able to create a rule without entering hosts limit" do
    rule = DiscoveryRule.new :name => "myrule",
      :search => "cpu_count > 1",
      :priority => "1",
      :hostgroup_id => @hostgroup.id,
      :organization_ids => [organization_one.id],
      :location_ids => [location_one.id]
    assert_valid rule
  end

  test "should be able to create a rule without entering priority" do
    rule = DiscoveryRule.new :name => "myrule",
      :search => "cpu_count > 1",
      :max_count => "1",
      :hostgroup_id => @hostgroup.id,
      :organization_ids => [organization_one.id],
      :location_ids => [location_one.id]
    assert_valid rule
  end

  test "should not be able to create a rule without a hostgroup-id" do
    rule = DiscoveryRule.new :name => "myrule",
      :search => "cpu_count > 1",
      :organization_ids => [organization_one.id],
      :location_ids => [location_one.id]
    refute_valid rule
    assert_equal "can't be blank", rule.errors[:hostgroup_id].first
  end

  test "should not be able to create a rule without a valid hostgroup" do
    rule = DiscoveryRule.new :name => "myrule",
      :search => "cpu_count > 1",
      :organization_ids => [organization_one.id],
      :location_ids => [location_one.id],
      :hostgroup_id => 99999
    refute_valid rule

    assert_equal "must be present.", rule.errors[:hostgroup].first
  end

  test_attributes :pid => '4ec7d76a-22ba-4c3e-952c-667a6f0a5728'
  test "should not create with invalid priority type" do
    rule = DiscoveryRule.new(
      :name => 'new_rule',
      :search => 'cpu_count = 1',
      :hostgroup_id => hostgroups(:unusual).id,
      :priority => 'invalid priority type'
    )
    refute_valid rule
    assert rule.errors.key?(:priority)
    assert_equal "is not a number", rule.errors[:priority].first
  end

  test "should not be able to create a rule with priority bigger than 2^31" do
    rule = DiscoveryRule.new :name => "myrule",
      :search => "cpu_count > 1",
      :priority => 2**31 + 1,
      :hostgroup_id => @hostgroup.id,
      :organization_ids => [organization_one.id],
      :location_ids => [location_one.id]
    refute_valid rule
    assert_equal "must be less than 2147483648", rule.errors[:priority].first
  end

  test_attributes :pid => '84503d8d-86f6-49bf-ab97-eff418d3e3d0'
  test "should not create with invalid max count type" do
    rule = DiscoveryRule.new(
      :name => 'new_rule',
      :search => 'cpu_count = 1',
      :hostgroup_id => hostgroups(:unusual).id,
      :max_count => 'invalid max_count type'
    )
    refute_valid rule
    assert rule.errors.key?(:max_count)
    assert_equal "is not a number", rule.errors[:max_count].first
  end

  test "should not be able to create a rule with max count bigger than 2^31" do
    rule = DiscoveryRule.new :name => "myrule",
      :search => "cpu_count > 1",
      :max_count => 2**31 + 1,
      :hostgroup_id => @hostgroup.id,
      :organization_ids => [organization_one.id],
      :location_ids => [location_one.id]
    refute_valid rule
    assert_equal "must be less than 2147483648", rule.errors[:max_count].first
  end

  test "should enforce hostgroup organizations" do
    skip unless SETTINGS[:organizations_enabled]
    rule = DiscoveryRule.new :name => "myrule",
      :search => "cpu_count > 1",
      :hostgroup_id => @hostgroup.id
    refute_valid rule
    assert_equal "Host group organization #{organization_one.name} must also be associated to the discovery rule", rule.errors[:organizations].first
  end

  test "should enforce hostgroup organizations and locations" do
    skip unless (SETTINGS[:organizations_enabled] && SETTINGS[:locations_enabled])
    loc = FactoryBot.create(:location, :name => "hgloc")
    @hostgroup.locations << loc
    @hostgroup.save!
    rule = DiscoveryRule.new :name => "myrule",
      :search => "cpu_count > 1",
      :hostgroup_id => @hostgroup.id,
      :organization_ids => [organization_one.id],
      :location_ids => [location_one.id]
    refute_valid rule
    assert_equal "Host group location #{loc.name} must also be associated to the discovery rule", rule.errors[:locations].first
  end

  context 'auditing related to discovery rule' do
    test "should be able to create audit on a rule creation" do
      rule = nil
      assert_difference 'Audit.count' do
        rule = FactoryBot.create(:discovery_rule, :with_auditing)
      end
      recent_audit = rule.audits.last
      assert_equal 'create', recent_audit.action
    end

    test "should create audit when updating a discovery rule" do
      rule = FactoryBot.create(:discovery_rule, :with_auditing)
      assert_difference 'rule.audits.count' do
        rule.enabled = false
        rule.save!
      end
      audit = rule.audits.last
      assert_equal 'update', audit.action
    end

    test "should create audit record when destroying a discovery rule" do
      rule = FactoryBot.create(:discovery_rule, :with_auditing)
      assert_difference 'Audit.count' do
        rule.destroy
      end
      audit = rule.audits.last
      assert_equal 'destroy', audit.action
    end

    test 'should be able to create audit record on changing hostgroup of rule' do
      rule = FactoryBot.create(:discovery_rule)
      hostgroup_one = FactoryBot.create(:hostgroup, :name => "test-hg")

      assert_difference 'hostgroup_one.associated_audits.count' do
        hostgroup_one.discovery_rules << rule
        hostgroup_one.save!
      end
    end

    test 'should be able to suggest next priority' do
      existing = FactoryBot.create(:discovery_rule)
      first_new = FactoryBot.create(:discovery_rule, :priority => DiscoveryRule.suggest_priority)
      assert first_new.priority > 0
      second_new = FactoryBot.create(:discovery_rule, :priority => DiscoveryRule.suggest_priority)
      assert_equal DiscoveryRule::STEP, second_new.priority - first_new.priority
    end
  end
end
