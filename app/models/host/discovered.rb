class Host::Discovered < ::Host::Base

  include ::Hostext::Search

  def self.importHostAndFacts data
    # data might already be a hash, from refresh_facts
    facts = data.is_a?(Hash) ? data : YAML::load(data)
    case facts
      # Discovered hosts don't have a name yet - use MAC for now
      # TODO: make this more intelligent, we might not have an eth0...
    when Puppet::Node::Facts
      name     = facts.values["macaddress_eth0"].downcase
      values   = facts.values
    when Hash
      name     = facts["macaddress_eth0"].downcase
      values   = facts
      return raise("invalid facts hash") unless name and values
    else
      return raise("Invalid Facts, much be a Puppet::Node::Facts or a Hash")
    end

    # TODO: Filter the facts to a known set - we don't need most of the full list

    if name
      h = Host::Discovered.find_by_name name
    end
    h ||= Host.new :name => name, :type => "Host::Discovered"

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
    self.save
  end

  def refresh_facts
    # TODO: Can we rely on self.ip? The lease might expire/change....
    begin
      logger.debug "retrieving facts from proxy"
      facts = ProxyAPI::Facts.new(:url => "http://#{self.ip}:8443").facts
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
