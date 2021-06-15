class Setting::Discovered < ::Setting
  BLANK_ATTRS << "discovery_location"
  BLANK_ATTRS << "discovery_organization"
  BLANK_ATTRS << "discovery_fact_column"
  BLANK_ATTRS << 'discovery_facts_highlights'
  BLANK_ATTRS << 'discovery_facts_storage'
  BLANK_ATTRS << 'discovery_facts_software'
  BLANK_ATTRS << 'discovery_facts_hardware'
  BLANK_ATTRS << 'discovery_facts_network'
  BLANK_ATTRS << 'discovery_facts_ipmi'

  STRING_PRESENCE_ATTRS = ['discovery_hostname', 'discovery_prefix']
  validates :value, :presence => true, :if => proc { |s| STRING_PRESENCE_ATTRS.include?(s.name) }

  def self.default_settings
    [
      self.set('discovery_location', N_("The default location to place discovered hosts in"), "", N_("Discovery location"), nil, { :collection => Proc.new {Hash[Location.all.map{|loc| [loc[:title], loc[:title]]}]} }),
      self.set('discovery_organization', N_("The default organization to place discovered hosts in"), "", N_("Discovery organization"), nil, { :collection => Proc.new {Hash[Organization.all.map{|org| [org[:title], org[:title]]}]} }),
      self.set('discovery_fact', N_("Fact name to use for primary interface detection"), "discovery_bootif", N_("Interface fact")),
      self.set('discovery_auto_bond', N_("Automatic bond interface (if another interface is detected on the same VLAN via LLDP)"), false, N_("Create bond interfaces")),
      self.set('discovery_clean_facts', N_("Clean all reported facts during provisioning (except discovery facts)"), false, N_("Clean all facts")),
      self.set('discovery_hostname', N_("List of facts to use for the hostname (separated by comma, first wins)"), "discovery_bootif", N_("Hostname facts")),
      self.set('discovery_auto', N_("Automatically provision newly discovered hosts, according to the provisioning rules"), false, N_("Auto provisioning")),
      self.set('discovery_reboot', N_("Automatically reboot or kexec discovered host during provisioning"), true, N_("Reboot")),
      self.set('discovery_prefix', N_("The default prefix to use for the host name, must start with a letter"), "mac", N_("Hostname prefix")),
      self.set('discovery_fact_column', N_("Extra facter columns to show in host lists (separate by comma)"), "", N_("Fact columns")),
      self.set('discovery_facts_highlights', N_("Regex to organize facts for highlights section - e.g. ^(abc|cde)$"), "", N_("Highlighted facts")),
      self.set('discovery_facts_storage', N_("Regex to organize facts for storage section"), "", N_("Storage facts")),
      self.set('discovery_facts_software', N_("Regex to organize facts for software section"), "", N_("Software facts")),
      self.set('discovery_facts_hardware', N_("Regex to organize facts for hardware section"), "", N_("Hardware facts")),
      self.set('discovery_facts_network', N_("Regex to organize facts for network section"), "", N_("Network facts")),
      self.set('discovery_facts_ipmi', N_("Regex to organize facts for ipmi section"), "", N_("IPMI facts")),
      self.set('discovery_lock', N_("Automatically generate PXE configuration to pin a newly discovered host to discovery"), false, N_("Lock PXE")),
      self.set('discovery_pxelinux_lock_template', N_("PXELinux template to be used when pinning a host to discovery"), 'pxelinux_discovery', N_("Locked PXELinux template name"), nil, { :collection => Proc.new {Hash[ProvisioningTemplate.where(:template_kind => TemplateKind.find_by_name(:snippet)).map{|template| [template[:name], template[:name]]}]} }),
      self.set('discovery_pxegrub_lock_template', N_("PXEGrub template to be used when pinning a host to discovery"), 'pxegrub_discovery', N_("Locked PXEGrub template name"), nil, { :collection => Proc.new {Hash[ProvisioningTemplate.where(:template_kind => TemplateKind.find_by_name(:snippet)).map{|template| [template[:name], template[:name]]}]} }),
      self.set('discovery_pxegrub2_lock_template', N_("PXEGrub2 template to be used when pinning a host to discovery"), 'pxegrub2_discovery', N_("Locked PXEGrub2 template name"), nil, { :collection => Proc.new {Hash[ProvisioningTemplate.where(:template_kind => TemplateKind.find_by_name(:snippet)).map{|template| [template[:name], template[:name]]}]} }),
      self.set('discovery_always_rebuild_dns', N_("Force DNS entries creation when provisioning discovered host"), true, N_("Force DNS")),
      self.set('discovery_error_on_existing', N_("Do not allow to discover existing managed host matching MAC of a provisioning NIC (errors out early)"), false, N_("Error on existing NIC")),
      self.set('discovery_naming', N_("Discovery hostname naming pattern"), 'Fact', N_("Type of name generator"), nil, {:collection => Proc.new {::Host::Discovered::NAMING_PATTERNS} }),
      self.set('discovery_prefer_ipv6', N_("Prefer IPv6 to IPv4 when calling discovered nodes"), false, N_("Prefer IPv6")),
    ]
  end

  def self.discovery_fact_column_array
    from_array(Setting['discovery_fact_column'])
  end

  def self.discovery_hostname_fact_array
    return [] if !Setting['discovery_hostname'].present?
    from_array Setting['discovery_hostname']
  end

  def self.discovery_lock?
    Foreman::Cast.to_bool(Setting['discovery_lock'])
  end

  def self.from_array(setting)
    return [] unless setting.present?
    setting.to_s.split(",").map(&:strip)
  rescue Exception => e
    logger.warn "Failed to parse discovery_fact_column, ignoring: #{e}"
    []
  end
end
