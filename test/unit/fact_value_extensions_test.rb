require 'test_helper'

class FactValueExtensionsTest < ActiveSupport::TestCase
  describe '.host' do
    test 'returns discovered_host' do
      discovered_host = FactoryGirl.create(:discovered_host, :with_facts, :fact_count => 1)
      fact_value = discovered_host.fact_values.first
      assert fact_value.discovered_host, fact_value.host
    end
  end
end
