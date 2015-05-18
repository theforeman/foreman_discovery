require 'foreman_discovery/proxy_operations'

class Host::Discovered < ::Host::Base
  include ScopedSearchExtensions

  belongs_to :hostgroup
  has_one    :discovery_attribute_set, :foreign_key => :host_id, :dependent => :destroy

  validates :discovery_attribute_set, :presence => true

  delegate :memory, :cpu_count, :disk_count, :disks_size, :to => :discovery_attribute_set

  scoped_search :on => :name, :complete_value => true, :default_order => true
  scoped_search :on => :last_report, :complete_value => true
  scoped_search :on => :ip, :complete_value => true
  scoped_search :on => :mac, :complete_value => true
  scoped_search :in => :model, :on => :name, :complete_value => true, :rename => :model
  scoped_search :in => :fact_values, :on => :value, :in_key => :fact_names, :on_key => :name, :rename => :facts, :complete_value => true, :only_explicit => true
  scoped_search :in => :location, :on => :name, :rename => :location, :complete_value => true         if SETTINGS[:locations_enabled]
  scoped_search :in => :organization, :on => :name, :rename => :organization, :complete_value => true if SETTINGS[:organizations_enabled]
  scoped_search :in => :subnet, :on => :network, :complete_value => true, :rename => :subnet
  scoped_search :in => :subnet, :on => :name, :complete_value => true, :rename => 'subnet.name'
  scoped_search :in => :discovery_attribute_set, :on => :cpu_count, :rename => :cpu_count, :complete_value => true, :only_explicit => true
  scoped_search :in => :discovery_attribute_set, :on => :memory, :rename => :memory, :complete_value => true, :only_explicit => true
  scoped_search :in => :discovery_attribute_set, :on => :disk_count, :rename => :disk_count, :complete_value => true, :only_explicit => true
  scoped_search :in => :discovery_attribute_set, :on => :disks_size, :rename => :disks_size, :complete_value => true, :only_explicit => true

  def self.import_host_and_facts facts
    raise(::Foreman::Exception.new(N_("Invalid facts, must be a Hash"))) unless facts.is_a?(Hash)
    fact_name = Setting[:discovery_fact] || 'discovery_bootif'
    prefix_from_settings = Setting[:discovery_prefix]
    hostname_prefix = prefix_from_settings if prefix_from_settings.present? && prefix_from_settings.match(/^[a-zA-Z].*/)
    hostname_prefix ||= 'mac'

    macfact = facts[fact_name].try(:downcase)
    raise(::Foreman::Exception.new(N_("Invalid facts: hash does not contain the required fact '%s'"), fact_name)) unless macfact
    begin
      macfact = Net::Validations.normalize_mac(macfact)
    rescue ArgumentError => e
      macfact = facts['discovery_bootif'].try(:downcase)
    end

    hostname = macfact.try(:downcase).try(:gsub,/:/,'').try(:sub,/^/, hostname_prefix)
    raise(::Foreman::Exception.new(N_("Invalid facts: hash does not contain IP address"))) unless facts['ipaddress']

    # filter facts
    facts.reject!{|k,v| k =~ /kernel|operatingsystem|osfamily|ruby|path|time|swap|free|filesystem/i }

    h = ::Host::Discovered.find_by_name hostname
    h ||= Host.new :name => hostname, :type => "Host::Discovered"
    h.type = "Host::Discovered"
    h.mac = macfact


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

    h.save(:validate => false) if h.new_record?
    state = h.import_facts(facts)
    return h, state
  end

  def import_facts facts
    # Discovered Hosts won't report in via puppet, so we can use that field to
    # record the last time it sent facts...
    self.last_report = Time.now
    super
  end

  def setup_clone
    # Nic::Managed needs this method but Discovered hosts shouldn't
    # be doing orchestration anyway...
    clone
  end

  def attributes_to_import_from_facts
    super
  end

  def populate_fields_from_facts facts = self.facts_hash, type = 'puppet'
    # type arg only added in 1.7
    if Gem::Dependency.new('', '>= 1.7').match?('', SETTINGS[:version].notag)
      importer = super
    else
      importer = super(facts)
    end
    self.primary_interface.subnet = Subnet.subnet_for(self.primary_interface.ip)
    self.discovery_attribute_set = DiscoveryAttributeSet.where(:host_id => id).first_or_create
    self.discovery_attribute_set.update_attributes(import_from_facts)
    self.save
  end

  def import_from_facts(facts = self.facts_hash)
    cpu_count  = facts['physicalprocessorcount'].to_i rescue 0
    memory     = facts['memorysize_mb'].to_f.ceil rescue 0
    disks      = facts.select { |key, value| key.to_s =~ /blockdevice.*_size/ }
    disks_size = 0
    disk_count = 0

    if disks.any?
      disks.values.each { |size| disks_size += (size.to_f rescue 0) }
      disk_count = disks.size
      # Turning disks_size to closest Mega for easier to read UI
      disks_size = (disks_size / 1024 / 1024).ceil if disks_size > 0
    end

    {:cpu_count => cpu_count, :memory => memory, :disk_count => disk_count, :disks_size => disks_size}
  end

  # no need to store anything in the db if the password is our default
  def root_pass
    read_attribute(:root_pass).blank? ? (hostgroup.try(:root_pass) || Setting[:root_pass]) : read_attribute(:root_pass)
  end

  def proxy_url
    if subnet.present? && subnet.discovery.present?
      { :url => subnet.discovery.url + "/discovery/#{self.ip}", :type => 'proxy'}
    else
      { :url => "http://#{self.ip}:8443", :type => 'foreman' }
    end
  end

  def refresh_facts
    # TODO: Can we rely on self.ip? The lease might expire/change....
    begin
      logger.debug "retrieving facts from proxy from url: #{proxy_url[:url]}"
      facts = ForemanDiscovery::ProxyOperations.new(:url => proxy_url[:url], :operation => 'facts').parse_get_operation
    rescue Exception => e
      raise _("Could not get facts from proxy %{url}: %{error}") % {:url => proxy_url[:url], :error => e}
    end

    return self.class.import_host_and_facts facts
  end

  def reboot
    logger.info "ForemanDiscovery: Rebooting #{name}"
    proxy_url = self.proxy_url

    if proxy_url[:type] == 'proxy'
      status = ForemanDiscovery::ProxyOperations.new(:url => proxy_url[:url], :operation => 'reboot').parse_put_operation
    else
      status = ::ProxyAPI::BMC.new(:url => "http://#{self.ip}:8443").power :action => "cycle"
    end

    msg = status ? 'successful' : 'failed'
    logger.info "ForemanDiscovery: reboot result: #{msg}"
    status
    rescue => e
      logger.info "ForemanDiscovery: reboot result: failed"
      logger.warn e.backtrace.join('\n')
      raise e
  end

  def self.model_name
    ActiveModel::Name.new(Host)
  end

  def compute_resource
    false
  end

  def lookup_value_match
    # We don't really expect lookup values to be used to match discovered hosts,
    # so simply put a string that won't match anything here
    "discovery-not-matched"
  end

end
