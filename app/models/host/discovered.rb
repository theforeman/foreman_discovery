class Host::Discovered < ::Host::Base
  audited :except => [:last_report]
  has_associated_audits
  # redefine audits relation because of the type change (by default the relation will look for auditable_type = 'Host::Managed')
  has_many :audits, -> { where(:auditable_type => 'Host::Base') }, :foreign_key => :auditable_id, :class_name => 'Audited::Audit'

  extend Foreman::TelemetryHelper
  include ScopedSearchExtensions
  include BelongsToProxies
  include ::Hostext::OperatingSystem

  has_one :discovery_attribute_set, :foreign_key => :host_id, :dependent => :destroy
  validates_associated :discovery_attribute_set

  delegate :memory, :cpu_count, :disk_count, :disks_size, :to => :discovery_attribute_set, :allow_nil => true
  after_destroy :delete_notification

  scoped_search :on => :name, :complete_value => true
  scoped_search :on => :created_at, :default_order => :desc, :only_explicit => true
  scoped_search :on => :last_report, :complete_value => true, :only_explicit => true
  scoped_search :relation => :primary_interface, :on => :ip, :complete_value => true
  scoped_search :relation => :primary_interface, :on => :mac, :complete_value => true
  scoped_search :relation => :model, :on => :name, :complete_value => true, :rename => :model, :only_explicit => true
  scoped_search :relation => :fact_values, :on => :value, :in_key => :fact_names, :on_key => :name, :rename => :facts, :complete_value => true, :only_explicit => true
  scoped_search :relation => :location, :on => :name, :rename => :location, :complete_value => true, :only_explicit => true
  scoped_search :on => :location_id, :complete_value => false, :only_explicit => true, :validator => ScopedSearch::Validators::INTEGER
  scoped_search :relation => :organization, :on => :name, :rename => :organization, :complete_value => true, :only_explicit => true
  scoped_search :on => :organization_id, :complete_value => false, :only_explicit => true, :validator => ScopedSearch::Validators::INTEGER
  scoped_search :relation => :subnet, :on => :network, :complete_value => true, :rename => :subnet
  scoped_search :relation => :subnet, :on => :name, :complete_value => true, :rename => 'subnet.name'
  scoped_search :relation => :discovery_attribute_set, :on => :cpu_count, :rename => :cpu_count, :complete_value => true, :only_explicit => true
  scoped_search :relation => :discovery_attribute_set, :on => :memory, :rename => :memory, :complete_value => true, :only_explicit => true
  scoped_search :relation => :discovery_attribute_set, :on => :disk_count, :rename => :disk_count, :complete_value => true, :only_explicit => true
  scoped_search :relation => :discovery_attribute_set, :on => :disks_size, :rename => :disks_size, :complete_value => true, :only_explicit => true

  default_scope lambda {
    where(taxonomy_conditions).order("hosts.created_at DESC")
  }

  NAMING_PATTERNS = {
    'Fact' => _('Fact + prefix'),
    'Random-name' => _('Random name'),
    'MAC-name' => _('MAC-based name')
  }.freeze

  # Discovery import workflow:
  # discovered#import_host ->
  # ForemanDiscovery::HostFactImporter#import_facts ->
  # ::HostFactImporter#import_facts ->
  # ::HostFactImporter#parse_facts ->
  # discovered#populate_fields_from_facts ->
  # base#populate_fields_from_facts ->
  # base#set_interfaces ->
  # discovered#populate_discovery_fields_from_facts
  def self.import_host facts
    raise(::Foreman::Exception.new(N_("Invalid facts, must be a Hash"))) unless facts.is_a?(Hash) || facts.is_a?(ActionController::Parameters)

    # filter facts
    facts.reject!{|k,v| k =~ /kernel|operatingsystem|osfamily|ruby|path|time|swap|free|filesystem/i }

    raise ::Foreman::Exception.new(N_("Expected discovery_fact '%s' is missing, unable to detect primary interface and set hostname") % FacterUtils::bootif_name) unless FacterUtils::bootif_present(facts)

    # construct hostname
    bootif_mac = FacterUtils::bootif_mac(facts).try(:downcase)
    hostname = ''
    if Setting[:discovery_naming] == 'MAC-name'
      hostname = NameGenerator.new.generate_next_mac_name(bootif_mac)
    elsif Setting[:discovery_naming] == 'Random-name'
      hostname = NameGenerator.new.generate_next_random_name
    else
      prefix_from_settings = Setting[:discovery_prefix]
      hostname_prefix = prefix_from_settings if prefix_from_settings.present? && prefix_from_settings.match(/^[a-zA-Z].*/)
      name_fact = return_first_valid_fact(Setting::Discovered.discovery_hostname_fact_array, facts)
      raise(::Foreman::Exception.new(N_("Invalid facts: hash does not contain a valid value for any of the facts in the discovery_hostname setting: %s"), Setting::Discovered.discovery_hostname_fact_array.join(', '))) unless name_fact && name_fact.present?
      hostname = normalize_string_for_hostname("#{hostname_prefix}#{name_fact}")
    end
    Rails.logger.warn "Hostname does not start with an alphabetical character" unless hostname.downcase.match(/^[a-z]/)

    # check for existing managed hosts and fail or warn
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
      telemetry_increment_counter(:new_discovered_hosts)
    else
      Rails.logger.warn "Multiple (#{existing_discovery_hosts.count}) discovery hosts found with MAC address #{name_fact} - picking most recent NIC entry" if existing_discovery_hosts.count > 1
      host = existing_discovery_hosts.first.host
      telemetry_increment_counter(:updated_discovered_hosts)
    end

    # and save (interfaces are created via puppet parser extension)
    host.save(:validate => false) if host.new_record?
    importer = ForemanDiscovery::HostFactImporter.new(host)
    raise ::Foreman::Exception.new(N_("Facts could not be imported")) unless importer.import_facts(facts)
    host
  rescue
    telemetry_increment_counter(:failed_discovered_hosts)
    raise
  end

  def setup_clone
    # Nic::Managed needs this method but Discovered hosts shouldn't
    # be doing orchestration anyway...
    clone
  end

  def attributes_to_import_from_facts
    super
  end

  def populate_fields_from_facts(parser, type, source_proxy)
    facts = parser.facts

    # detect interfaces and primary interface using extensions
    super(parser, type, source_proxy)

    populate_discovery_fields_from_facts(facts)
    create_notification
    parser
  end

  # set additional discovery attributes
  def populate_discovery_fields_from_facts(facts)
    ForemanDiscovery::ImportHookService.new(host: self, facts: facts).after_populate
  ensure
    begin
      self.save!
    rescue => _
      telemetry_increment_counter(:failed_discovered_hosts)
      raise
    end
  end

  def proxied?
    subnet.present? && subnet.discovery.present?
  end

  def proxy_url(node_ip)
    proxied? ? subnet.discovery.url + "/discovery/#{node_ip}" : "https://#{node_ip}:8443"
  end

  def refresh_facts
    facts = ::ForemanDiscovery::NodeAPI::Inventory.new(:url => proxy_url(self.ip)).facter
    self.class.import_host facts
    ::ForemanDiscovery::HostFactImporter.new(self).import_facts facts
  rescue => e
    ::Foreman::Logging.exception("Unable to get facts from proxy", e)
    raise ::Foreman::WrappedException.new(e, N_("Could not get facts from proxy %{url}: %{error}"), :url => proxy_url(self.ip), :error => e)
  end

  def reboot(old_ip = nil, new_ip = nil)
    # perform the action against the original lease as well as the new reservation
    ips = [old_ip, new_ip, self.ip].compact.uniq
    logger.debug "Performing reboot calls against #{ips.to_sentence}, facts left #{facts.count}"
    ips.each do |next_ip|
      begin
        node_url = proxy_url(next_ip)
        logger.debug "Performing reboot call against #{node_url}"
        resource = ::ForemanDiscovery::NodeAPI::Power.service(:url => node_url)
        return true if resource.reboot
      rescue => e
        msg = N_("Unable to perform reboot on %{name} (%{url}): %{msg}")
        ::Foreman::Logging.exception(msg % { :name => name, :url => node_url, :msg => e.to_s }, e)
      end
    end
    msg = N_("Unable to perform %{action} on %{ips}")
    raise ::Foreman::Exception.new(msg, action: "reboot", ips: ips.to_sentence)
  end

  def kexec(json, old_ip = nil, new_ip = nil)
    # perform the action against the original lease as well as the new reservation
    ips = [old_ip, new_ip, self.ip].compact.uniq
    logger.debug "Performing kexec calls against #{ips.to_sentence}, #{facts.count} facts left"
    ips.each do |next_ip|
      begin
        node_url = proxy_url(next_ip)
        logger.debug "Performing kexec call against #{node_url}"
        resource = ::ForemanDiscovery::NodeAPI::Power.service(:url => node_url)
        return true if resource.kexec(json)
      rescue => e
        msg = N_("Unable to perform kexec on %{name} (%{url}): %{msg}")
        ::Foreman::Logging.exception(msg % { :name => name, :url => node_url, :msg => e.to_s }, e)
      end
    end
    msg = N_("Unable to perform %{action} on %{ips}")
    raise ::Foreman::Exception.new(msg, action: "kexec", ips: ips.to_sentence)
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
    org_recipients = find_organization_users
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
