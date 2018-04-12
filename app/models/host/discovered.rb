class Host::Discovered < ::Host::Base
  include ScopedSearchExtensions
  include Foreman::Renderer
  include BelongsToProxies
  include ::Hostext::OperatingSystem

  belongs_to :hostgroup
  has_one    :discovery_attribute_set, :foreign_key => :host_id, :dependent => :destroy

  validates :discovery_attribute_set, :presence => true

  delegate :memory, :cpu_count, :disk_count, :disks_size, :to => :discovery_attribute_set
  after_destroy :delete_notification

  scoped_search :on => :name, :complete_value => true
  scoped_search :on => :created_at, :default_order => :desc, :only_explicit => true
  scoped_search :on => :last_report, :complete_value => true, :only_explicit => true
  scoped_search :relation => :primary_interface, :on => :ip, :complete_value => true
  scoped_search :relation => :primary_interface, :on => :mac, :complete_value => true
  scoped_search :relation => :model, :on => :name, :complete_value => true, :rename => :model
  scoped_search :relation => :fact_values, :on => :value, :in_key => :fact_names, :on_key => :name, :rename => :facts, :complete_value => true, :only_explicit => true
  if SETTINGS[:locations_enabled]
    scoped_search :relation => :location, :on => :name, :rename => :location, :complete_value => true, :only_explicit => true
    scoped_search :on => :location_id, :complete_value => false, :only_explicit => true, :validator => ScopedSearch::Validators::INTEGER
  end
  if SETTINGS[:organizations_enabled]
    scoped_search :relation => :organization, :on => :name, :rename => :organization, :complete_value => true, :only_explicit => true
    scoped_search :on => :organization_id, :complete_value => false, :only_explicit => true, :validator => ScopedSearch::Validators::INTEGER
  end
  scoped_search :relation => :subnet, :on => :network, :complete_value => true, :rename => :subnet
  scoped_search :relation => :subnet, :on => :name, :complete_value => true, :rename => 'subnet.name'
  scoped_search :relation => :discovery_attribute_set, :on => :cpu_count, :rename => :cpu_count, :complete_value => true, :only_explicit => true
  scoped_search :relation => :discovery_attribute_set, :on => :memory, :rename => :memory, :complete_value => true, :only_explicit => true
  scoped_search :relation => :discovery_attribute_set, :on => :disk_count, :rename => :disk_count, :complete_value => true, :only_explicit => true
  scoped_search :relation => :discovery_attribute_set, :on => :disks_size, :rename => :disks_size, :complete_value => true, :only_explicit => true

  default_scope lambda {
    where(taxonomy_conditions).order("hosts.created_at DESC")
  }

  # Discovery import workflow:
  # discovered#import_host ->
  #  discovered#import_facts -> base#import_facts -> base#parse_facts ->
  #  discovered#populate_fields_from_facts -> base#populate_fields_from_facts -> base#set_interfaces
  #  discovered#populate_discovery_fields_from_facts
  def self.import_host facts
    raise(::Foreman::Exception.new(N_("Invalid facts, must be a Hash"))) unless facts.is_a?(Hash) || facts.is_a?(ActionController::Parameters)

    # filter facts
    facts.reject!{|k,v| k =~ /kernel|operatingsystem|osfamily|ruby|path|time|swap|free|filesystem/i }

    raise ::Foreman::Exception.new(N_("Expected discovery_fact '%s' is missing, unable to detect primary interface and set hostname") % FacterUtils::bootif_name) unless FacterUtils::bootif_present(facts)

    # construct hostname
    prefix_from_settings = Setting[:discovery_prefix]
    hostname_prefix = prefix_from_settings if prefix_from_settings.present? && prefix_from_settings.match(/^[a-zA-Z].*/)

    name_fact = return_first_valid_fact(Setting::Discovered.discovery_hostname_fact_array, facts)
    raise(::Foreman::Exception.new(N_("Invalid facts: hash does not contain a valid value for any of the facts in the discovery_hostname setting: %s"), Setting::Discovered.discovery_hostname_fact_array.join(', '))) unless name_fact && name_fact.present?
    hostname = normalize_string_for_hostname("#{hostname_prefix}#{name_fact}")
    Rails.logger.warn "Hostname does not start with an alphabetical character" unless hostname.downcase.match(/^[a-z]/)

    # check for existing managed hosts and fail or warn
    bootif_mac = FacterUtils::bootif_mac(facts).try(:downcase)
    existing_managed = Nic::Managed.joins(:host).where(:mac => bootif_mac, :provision => true, :hosts => {:type => "Host::Managed"}).limit(1)
    if existing_managed.count > 0
      if Setting[:discovery_error_on_existing]
        raise ::Foreman::Exception.new("One or more existing managed hosts found: %s", "#{existing_managed.first.name}/#{bootif_mac}")
      else
        Rails.logger.warn("One or more existing managed hosts found: #{existing_managed.first.name}/#{bootif_mac}")
      end
    end

    # find existing discovered host (pick the oldest if multiple) or create new discovery host record
    existing_discovery_hosts = Nic::Managed.joins(:host).where(:mac => bootif_mac, :provision => true, :hosts => {:type => "Host::Discovered"}).order('created_at DESC')
    if existing_discovery_hosts.empty?
      host = Host.new(:name => hostname, :type => "Host::Discovered")
    else
      Rails.logger.warn "Multiple (#{existing_discovery_hosts.count}) discovery hosts found with MAC address #{name_fact} - picking most recent NIC entry" if existing_discovery_hosts.count > 1
      host = existing_discovery_hosts.first.host
    end

    # and save (interfaces are created via puppet parser extension)
    host.save(:validate => false) if host.new_record?
    raise ::Foreman::Exception.new(N_("Facts could not be imported")) unless host.import_facts(facts)
    host
  end

  def import_facts(facts)
    # Discovered Hosts won't report in via puppet, so we can use that field to
    # record the last time it sent facts...
    self.last_report = Time.now
    # Set the correct facts type for new foreman facts importing code.
    facts[:_type] = :foreman_discovery if SETTINGS[:version].short > '1.16'
    super(facts)
  end

  def setup_clone
    # Nic::Managed needs this method but Discovered hosts shouldn't
    # be doing orchestration anyway...
    clone
  end

  def attributes_to_import_from_facts
    super
  end

  def populate_fields_from_facts(*params)
    if SETTINGS[:version].short > '1.16'
      parser, type, source_proxy = params
      facts = parser.facts
      # detect interfaces and primary interface using extensions
      super(parser, type, source_proxy)
    else
      # backwards compatibility
      facts = params[0] || self.facts_hash
      parser = super(facts, :foreman_discovery)
    end

    populate_discovery_fields_from_facts(facts)
    create_notification
    parser
  end

  def populate_discovery_fields_from_facts(facts)
    # set discovery search attributes first
    self.discovery_attribute_set = DiscoveryAttributeSet.where(:host_id => id).first_or_create
    self.discovery_attribute_set.update_attributes(import_from_facts)
    # set additional discovery attributes
    primary_ip = self.primary_interface.ip
    unless primary_ip.nil?
      subnet = Subnet.subnet_for(primary_ip)
      if subnet
        Rails.logger.info "Detected subnet: #{subnet} with taxonomy #{subnet.organizations.collect(&:name)}/#{subnet.locations.collect(&:name)}"
      else
        Rails.logger.warn "Subnet could not be detected for #{primary_ip}"
      end
      # set subnet
      self.primary_interface.subnet = subnet
      # set location and organization
      if SETTINGS[:locations_enabled]
        self.location = Location.find_by_title(facts["foreman_location"] || facts["discovery_location"]) ||
          Location.find_by_title(Setting[:discovery_location]) ||
          subnet.try(:locations).try(:first) ||
          Location.first
        Rails.logger.info "Assigned location: #{self.location}"
      end
      if SETTINGS[:organizations_enabled]
        self.organization = Organization.find_by_title(facts["foreman_organization"] || facts["discovery_organization"]) ||
          Organization.find_by_title(Setting[:discovery_organization]) ||
          subnet.try(:organizations).try(:first) ||
          Organization.first
        Rails.logger.info "Assigned organization: #{self.organization}"
      end
    else
      Rails.logger.warn "Unable to assign subnet - reboot trigger may not be possible, primary interface is missing IP address"
    end

    # lock the host into discovery via PXE, if feature is enabled in settings
    lock_templates if Setting::Discovered.discovery_lock? && self.subnet.tftp?
  ensure
    self.save!
  end

  def lock_templates
    @host = self
    TemplateKind::PXE.each do |kind|
      template_name = Setting["discovery_#{kind.downcase}_lock_template"]
      Rails.logger.info "Locking discovered host #{self.mac} in subnet #{subnet} via #{template_name} template"
      template = unattended_render(::ProvisioningTemplate.find_by_name(template_name).template)
      subnet.tftp_proxy.set(kind, mac, :pxeconfig => template)
    end
  rescue ::Foreman::Exception => e
    ::Foreman::Logging.exception("Could not set tftp_proxy from proxy", e)
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

  def proxied?
    subnet.present? && subnet.discovery.present?
  end

  def proxy_url
    proxied? ? subnet.discovery.url + "/discovery/#{self.ip}" : "https://#{self.ip}:8443"
  end

  def refresh_facts
    facts = ::ForemanDiscovery::NodeAPI::Inventory.new(:url => proxy_url).facter
    self.class.import_host facts
    import_facts facts
  rescue => e
    ::Foreman::Logging.exception("Unable to get facts from proxy", e)
    raise ::Foreman::WrappedException.new(e, N_("Could not get facts from proxy %{url}: %{error}"), :url => proxy_url, :error => e)
  end

  def reboot
    resource = ::ForemanDiscovery::NodeAPI::Power.service(:url => proxy_url)
    resource.reboot
  rescue => e
    ::Foreman::Logging.exception("Unable to reboot #{name}", e)
    raise ::Foreman::WrappedException.new(e, N_("Unable to reboot %{name} via %{url}: %{msg}"), :name => name, :url => proxy_url, :msg => e.to_s)
  end

  def kexec json
    resource = ::ForemanDiscovery::NodeAPI::Power.service(:url => proxy_url)
    resource.kexec json
  rescue => e
    ::Foreman::Logging.exception("Unable to perform kexec on #{name}", e)
    raise ::Foreman::WrappedException.new(e, N_("Unable to perform kexec on %{name} via %{url}: %{msg}"), :name => name, :url => proxy_url, :msg => e.to_s)
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

  def self.normalize_string_for_hostname(hostname)
    hostname = hostname.to_s.downcase.gsub(/(^[^a-z0-9]*|[^a-z0-9\-]|[^a-z0-9]*$)/,'')
    raise(::Foreman::Exception.new(N_("Invalid hostname: Could not normalize the hostname"))) unless hostname && hostname.present?
    hostname
  end

  def self.return_first_valid_fact(facts_array, facts)
    return facts[facts_array] if !facts_array.is_a?(Array)
    facts_array.each do |value|
      return facts[value] if !facts[value].nil?
    end
    return nil
  end

  def create_notification
    ForemanDiscovery::UINotifications::NewHost.deliver!(self)
  end

  def delete_notification
    ForemanDiscovery::UINotifications::DestroyHost.deliver!(self)
  end

  def notification_recipients_ids
    org_recipients = find_organization_users if Taxonomy.organizations_enabled
    org_recipients ||= []

    admins = User.unscoped.only_admin.except_hidden.
      reorder('').distinct.pluck(:id)
    (org_recipients + admins).uniq
  end

  private

  def find_organization_users
    return [] unless organization.present?
    organization_users = if organization.ignore_types.include? 'User'
                           User.unscoped.all
                         else
                           organization.users
                         end

    organization_users.find_all do |user|
      user.can? :create_hosts
    end.pluck(:id)
  end
end
