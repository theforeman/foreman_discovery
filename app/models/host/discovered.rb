require 'foreman_discovery/facts'

class Host::Discovered < ::Host::Base

  belongs_to :location
  belongs_to :organization
  belongs_to :subnet

  scoped_search :on => :name, :complete_value => true, :default_order => true
  scoped_search :on => :last_report, :complete_value => true
  scoped_search :on => :ip, :complete_value => true
  scoped_search :on => :mac, :complete_value => true
  scoped_search :in => :model, :on => :name, :complete_value => true, :rename => :model
  scoped_search :in => :fact_values, :on => :value, :in_key => :fact_names, :on_key => :name, :rename => :facts, :complete_value => true, :only_explicit => true
  scoped_search :in => :location, :on => :name, :rename => :location, :complete_value => true         if SETTINGS[:locations_enabled]
  scoped_search :in => :organization, :on => :name, :rename => :organization, :complete_value => true if SETTINGS[:organizations_enabled]
  scoped_search :in => :subnet, :on => :network, :complete_value => true, :rename => :subnet

  # This `where` shouldn't be necessary, but randomly the sql query on the line above
  # sometimes loses the `where` clause, leading to all Hosts on the Discovery index
  # this seems like a rails bug, TODO: figure out whats really wrong here
  scope :list, lambda { where(:type => "Host::Discovered").includes(:model, :location, :organization) }

  def self.importHostAndFacts data
    # data might already be a hash, from refresh_facts
    facts = data.is_a?(Hash) ? data : YAML::load(data)
    case facts
      # Discovered hosts don't have a name yet - use MAC for now
      # TODO: make this more intelligent, we might not have an eth0...
      when Puppet::Node::Facts
        name   = facts.values["macaddress_eth0"].downcase.gsub(/:/,'')
        values = facts.values
      when Hash
        name   = facts["macaddress_eth0"].downcase.gsub(/:/,'')
        values = facts
        return raise("invalid facts hash") unless name and values
      else
        return raise("Invalid Facts, much be a Puppet::Node::Facts or a Hash")
    end

    # filter facts
    values.reject!{|k,v| k =~ /kernel|operatingsystem|osfamily|ruby|path|time|swap|free|filesystem|version/i }

    if name
      h = ::Host::Discovered.find_by_name name
    end
    h ||= Host.new :name => name, :type => "Host::Discovered"
    h.type = "Host::Discovered"
    h.mac = values["macaddress_eth0"]

    if SETTINGS[:locations_enabled]
      begin
        h.location = (Location.find_by_name Setting[:discovery_location]) || Location.first
      rescue
        h.location = Location.first
      end
    end
    if SETTINGS[:organizations_enabled]
      begin
        h.organization = (Organization.find_by_name Setting[:discovery_organization]) || Organization.first
      rescue
        h.organization = Organization.first
      end
    end

    h.save if h.new_record?
    h.importFacts(name, values)
  end

  def importFacts name, facts
    # Discovered Hosts won't report in via puppet, so we can use that field to
    # record the last time it sent facts...
    self.last_report = Time.now
    super
  end

  def attributes_to_import_from_facts
    super + [:ip]
  end

  def populateFieldsFromFacts facts = self.facts_hash
    importer = super
    self.subnet = Subnet.subnet_for(importer.ip)
    self.save
  end

  def refresh_facts
    # TODO: Can we rely on self.ip? The lease might expire/change....
    begin
      logger.debug "retrieving facts from proxy on ip: #{self.ip}"
      facts = ForemanDiscovery::Facts.new(:url => "http://#{self.ip}:8443").facts
    rescue Exception => e
      raise "Could not get facts from Proxy: #{e}"
    end

    return self.class.importHostAndFacts facts
  end

  def self.model_name
    ActiveModel::Name.new(Host)
  end

  def compute_resource
    false
  end

end
