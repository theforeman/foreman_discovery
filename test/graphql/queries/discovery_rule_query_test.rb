require 'test_plugin_helper'

module Queries
  class DiscoveryRuleQueryTest < GraphQLQueryTestCase
    let(:query) do
      <<-GRAPHQL
      query discoveryRuleQuery (
        $id: String!
      ) {
        discoveryRule(id: $id) {
          id
          createdAt
          updatedAt
          name
          enabled
          priority
          hostname
          search
          hostsLimit
          hostgroup {
            id
          }
          hosts {
            totalCount
            edges {
              node {
                id
              }
            }
          }
          locations {
            totalCount
            edges {
              node {
                id
              }
            }
          }
          organizations {
            totalCount
            edges {
              node {
                id
              }
            }
          }
        }
      }
      GRAPHQL
    end

    let(:discovery_rule) { FactoryBot.create(:discovery_rule) }
    let(:global_id) { Foreman::GlobalId.for(discovery_rule) }
    let(:variables) {{ id: global_id }}
    let(:data) { result['data']['discoveryRule'] }

    setup do
      FactoryBot.create(:host, :managed, discovery_rule: discovery_rule)
      discovery_rule.reload
    end

    test 'fetching discovery rule attributes' do
      assert_empty result['errors']
      assert_not_nil data

      assert_equal global_id, data['id']
      assert_equal discovery_rule.created_at.utc.iso8601, data['createdAt']
      assert_equal discovery_rule.updated_at.utc.iso8601, data['updatedAt']
      assert_equal discovery_rule.name, data['name']
      assert_equal discovery_rule.enabled, data['enabled']
      assert_equal discovery_rule.priority, data['priority']
      assert_equal discovery_rule.hostname, data['hostname']
      assert_equal discovery_rule.search, data['search']
      assert_equal discovery_rule.max_count, data['hostsLimit']

      assert_record discovery_rule.hostgroup, data['hostgroup']

      assert_collection discovery_rule.hosts, data['hosts'], type_name: 'Host'
      assert_collection discovery_rule.locations, data['locations']
      assert_collection discovery_rule.organizations, data['organizations']
    end
  end
end
