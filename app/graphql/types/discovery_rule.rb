module Types
  class DiscoveryRule < BaseObject
    #model_class ::ForemanOmaha::OmahaReport
    description 'A discovery rule'

    global_id_field :id
    timestamps
    field :name, String
    field :enabled, Boolean
    field :priority, Integer
    field :hostname, String
    field :search, String
    field :hosts_limit, Integer, null: false, method: :max_count

    belongs_to :hostgroup, Types::Hostgroup
    has_many :hosts, Types::Host
    has_many :locations, Types::Location
    has_many :organizations, Types::Organization
  end
end
