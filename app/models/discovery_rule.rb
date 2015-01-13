class DiscoveryRule < ActiveRecord::Base
  include Authorizable
  extend FriendlyId
  friendly_id :name
  include Parameterizable::ByIdName

  attr_accessible :name, :enabled, :hostgroup_id, :hostname, :max_count, :priority, :search

  validates :name, :presence => true, :uniqueness => true,
    :format => { :with => /\A(\S+)\Z/, :message => N_("can't contain white spaces.") }
  validates :search, :presence => true
  validates :hostname, :format => { :with => /\A[a-zA-Z<]/, :message => N_("must start with a letter or ERB.") },
    :allow_blank => true
  validates :hostgroup_id, :presence => true
  validates :max_count, :numericality => { only_integer: true }
  validates :priority, :presence => true, numericality: true
  validates_lengths_from_database

  belongs_to :hostgroup
  has_many :hosts

  scoped_search :on => :name, :complete_value => :true
  scoped_search :on => :priority

  def has_free_slots?
    max_count == 0 || hosts.size < max_count
  end
end
