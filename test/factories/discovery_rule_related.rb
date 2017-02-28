FactoryGirl.define do
  factory :discovery_rule do
    sequence(:name) { |n| "rule#{n}" }
    sequence(:priority) { |n| n }
    search "facts.fact1 == 'value1'"
    hostname ""
    hostgroup
    max_count 0
    enabled true
    organizations { [organization_one] } if SETTINGS[:organizations_enabled]
    locations { [location_one] } if SETTINGS[:locations_enabled]
  end
end

FactoryGirl.define do
  factory :discovered_host, class: 'Host::Discovered' do
    sequence(:name) { |n| "host#{n}" }
    sequence(:ip)   { |n| IPAddr.new(n, Socket::AF_INET).to_s }
    sequence(:mac)  { |n| "02:23:45:67:" + n.to_s(16).rjust(4, '0').insert(2, ':') }

    after(:build) do |discovered_host|
      attribute_set = DiscoveryAttributeSet.new(:host => discovered_host,
                                                :memory => '1',
                                                :cpu_count => '4')
      discovered_host.discovery_attribute_set = attribute_set
    end

    trait :with_facts do
      transient do
        fact_count 20
      end

      after(:create) do |discovered_host, evaluator|
        evaluator.fact_count.times do
          FactoryGirl.create(:fact_value, :discovered_host => discovered_host)
        end
      end
    end
  end
end
