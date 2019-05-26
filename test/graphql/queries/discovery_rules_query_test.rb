require 'test_plugin_helper'

module Queries
  class DiscoveryRulesQueryTest < GraphQLQueryTestCase
    let(:query) do
      <<-GRAPHQL
      query discoveryRulesQuery {
        discoveryRules {
          totalCount
          pageInfo {
            startCursor
            endCursor
            hasNextPage
            hasPreviousPage
          }
          edges {
            cursor
            node {
              id
            }
          }
        }
      }
      GRAPHQL
    end

    let(:data) { result['data']['discoveryRules'] }

    setup do
      FactoryBot.create_list(:discovery_rule, 2)
    end

    test 'fetching discovery rules attributes' do
      assert_empty result['errors']

      expected_count = DiscoveryRule.count

      assert_not_equal 0, expected_count
      assert_equal expected_count, data['totalCount']
      assert_equal expected_count, data['edges'].count
    end
  end
end
