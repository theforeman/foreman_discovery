FactoryGirl.define do
  factory :discovery_rule do
    sequence(:name) { |n| "rule#{n}" }
    sequence(:priority) { |n| n }
    search "facts.fact1 == 'value1'"
    hostname ""
    hostgroup
    max_count 0
    enabled true
  end
end

FactoryGirl.define do
  factory :discovered_host, class: 'Host::Discovered' do
    sequence(:name) { |n| "host#{n}" }
    sequence(:ip)   { |n| IPAddr.new(n, Socket::AF_INET).to_s }
    sequence(:mac)  { |n| "02:23:45:67:" + n.to_s(16).rjust(4, '0').insert(2, ':') }
    fact_values
  end
end
