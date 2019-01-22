FactoryBot.define do
  factory :discovery_rule do
    sequence(:name) { |n| "rule#{n}" }
    sequence(:priority) { |n| n }
    search { "facts.fact1 == 'value1'" }
    hostname { "" }
    hostgroup
    max_count { 0 }
    enabled { true }
    organizations { [organization_one] }
    locations { [location_one] }
  end
end
