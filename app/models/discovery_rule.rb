class DiscoveryRule < ActiveRecord::Base
  include Authorizable
  extend FriendlyId
  friendly_id :name
  include Parameterizable::ByIdName
  include Taxonomix

  attr_accessible :name, :priority, :search, :enabled, :hostgroup, :hostgroup_id, :max_count, :hostname

  validates :name, :presence => true, :uniqueness => true,
    :format => { :with => /\A(\S+)\Z/, :message => N_("can't contain white spaces.") }
  validates :search, :presence => true
  validates :hostname, :format => { :with => /\A[a-zA-Z<]/, :message => N_("must start with a letter or ERB.") },
    :allow_blank => true
  validates :hostgroup_id, :presence => true
  validates :max_count, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  validates :priority, :presence => true, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  validates_lengths_from_database
  before_validation :default_int_attributes
  before_validation :enforce_taxonomy

  belongs_to :hostgroup
  has_many :hosts

  scoped_search :on => :name, :complete_value => :true
  scoped_search :on => :priority
  scoped_search :on => :search
  scoped_search :on => :enabled
  scoped_search :in => :hostgroup, :on => :name, :complete_value => true, :rename => :hostgroup

  # with proc support, default_scope can no longer be chained
  # include all default scoping here
  default_scope lambda {
                  with_taxonomy_scope do
                    order("discovery_rules.name")
                  end
                }

  def default_int_attributes
   self.max_count ||= 0
   self.priority  ||= 0
  end

  def enforce_taxonomy
    return if hostgroup.nil?
    if SETTINGS[:organizations_enabled]
      unless (ms = hostgroup.organizations - organizations).empty?
        names = ms.collect(&:name).to_sentence
        errors.add(:organizations, n_("Host group organization %s must also be associated to the discovery rule", "Host group organizations %s must also be associated to the discovery rule", ms.size) % names)
      end
    end
    if SETTINGS[:locations_enabled]
      unless (ms = hostgroup.locations - locations).empty?
        names = ms.collect(&:name).to_sentence
        errors.add(:locations, n_("Host group location %s must also be associated to the discovery rule", "Host group locations %s must also be associated to the discovery rule", ms.size) % names)
      end
    end
  end
end
