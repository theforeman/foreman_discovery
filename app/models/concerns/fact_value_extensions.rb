module FactValueExtensions
  extend ActiveSupport::Concern

  included do
    belongs_to :discovered_host, :class_name => "Host::Discovered", :foreign_key => :host_id
    scoped_search :in => :discovered_host, :on => :id, :complete_enabled => false, :only_explicit => true, :rename => :discovered_host
  end
end
