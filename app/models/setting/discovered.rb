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

  def self.load_defaults
    # Check the table exists
    return unless super

    Setting.transaction do
      [
        self.set('discovery_fact', N_("Fact name to use for primary interface detection and hostname"), "discovery_bootif"),
        self.set('discovery_auto', N_("Automatically provision newly discovered hosts, according to the provisioning rules"), false),
        self.set('discovery_reboot', N_("Automatically reboot discovered host during provisioning"), true),
      ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
    end

    Setting.transaction do
      [
        self.set('discovery_prefix', N_("The default prefix to use for the host name, must start with a letter"), "mac"),
      ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
    end

    Setting.transaction do
      [
        self.set('discovery_fact_column', N_("Extra facter columns to show in host lists (separate by comma)"), ""),
      ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
    end

    if SETTINGS[:locations_enabled]
      Setting.transaction do
        [
          self.set('discovery_location', N_("The default location to place discovered hosts in"), ""),
        ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
      end
    end
    if SETTINGS[:organizations_enabled]
      Setting.transaction do
        [
          self.set('discovery_organization', N_("The default organization to place discovered hosts in"), "" ),
        ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
      end
    end

    Setting.transaction do
      [
          self.set('discovery_facts_highlights', N_("Regex to organize facts for highlights section"), ""),
          self.set('discovery_facts_storage', N_("Regex to organize facts for storage section"), ""),
          self.set('discovery_facts_software', N_("Regex to organize facts for software section"), ""),
          self.set('discovery_facts_hardware', N_("Regex to organize facts for hardware section"), ""),
          self.set('discovery_facts_network', N_("Regex to organize facts for network section"), ""),
          self.set('discovery_facts_ipmi', N_("Regex to organize facts for ipmi section"), ""),
      ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
    end
    true

  end

  def self.discovery_fact_column_array
    return [] if !Setting['discovery_fact_column'].present?
    list = []
    Setting['discovery_fact_column'].to_s.split(",").each do |value|
      list << value.strip
    end
  rescue => error
    logger.warn "Failed to parse comma delimited list [%s] into array. Error: %s" % [list,error]
  ensure
    list
  end
end
