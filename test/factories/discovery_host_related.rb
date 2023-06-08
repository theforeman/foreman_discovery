FactoryBot.define do
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
        fact_count { 20 }
      end

      after(:create) do |discovered_host, evaluator|
        evaluator.fact_count.times do
          FactoryBot.create(:fact_value, :host => discovered_host)
        end
      end
    end
  end
end
