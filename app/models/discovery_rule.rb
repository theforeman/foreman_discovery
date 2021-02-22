class DiscoveryRule < ApplicationRecord
  STEP = 100
  audited :associated_with => :hostgroup
  include Authorizable
  extend FriendlyId
  friendly_id :name
  include Parameterizable::ByIdName
  include Taxonomix

  validates :name, :presence => true, :uniqueness => true,
    :format => { :with => /\A(\S+)\Z/, :message => N_("can't contain white spaces.") }
  validates :search, :presence => true
  validates :hostname, :format => { :with => /\A[a-zA-Z<]/, :message => N_("must start with a letter or ERB.") },
    :allow_blank => true
  validates :hostgroup_id, :presence => true
  validates :hostgroup, :presence => {:message => N_("must be present.")}
  validates :max_count, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 2**31 }
  validates :priority, :presence => true, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 2**31 }
  validates_lengths_from_database
  validates_uniqueness_of :priority
  before_validation :default_int_attributes
  before_validation :enforce_taxonomy

  belongs_to :hostgroup
  has_many_hosts :dependent => :nullify

  scoped_search :on => :name, :complete_value => :true
  scoped_search :on => :priority, :only_explicit => true
  scoped_search :on => :search, :only_explicit => true
  scoped_search :on => :enabled
  scoped_search :relation => :hostgroup, :on => :name, :complete_value => true, :rename => :hostgroup, :only_explicit => true

  default_scope lambda {
    with_taxonomy_scope do
      order('discovery_rules.priority, discovery_rules.created_at')
    end
  }

  def default_int_attributes
   self.max_count ||= 0
   self.priority  ||= 0
  end

  def self.suggest_priority
    self.unscoped.maximum(:priority).to_i + STEP
  end

  def enforce_taxonomy
    return if hostgroup.nil?
    unless (ms = hostgroup.organizations - organizations).empty?
      names = ms.collect(&:name).to_sentence
      errors.add(:base, n_("Host group organization %s must also be associated to the discovery rule", "Host group organizations %s must also be associated to the discovery rule", ms.size) % names)
    end
    unless (ms = hostgroup.locations - locations).empty?
      names = ms.collect(&:name).to_sentence
      errors.add(:base, n_("Host group location %s must also be associated to the discovery rule", "Host group locations %s must also be associated to the discovery rule", ms.size) % names)
    end
  end
end
