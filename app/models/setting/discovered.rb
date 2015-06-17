class Setting::Discovered < ::Setting
  BLANK_ATTRS << "discovery_location"
  BLANK_ATTRS << "discovery_organization"
  BLANK_ATTRS << "discovery_fact_column"

  def self.load_defaults
    # Check the table exists
    return unless super

    Setting.transaction do
      [
        self.set('discovery_fact', _("Fact name to use for primary interface detection and hostname"), "discovery_bootif"),
        self.set('discovery_auto', _("Automatically provision newly discovered hosts, according to the provisioning rules"), false),
      ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
    end

    Setting.transaction do
      [
        self.set('discovery_prefix', _("The default prefix to use for the host name, must start with a letter"), "mac"),
      ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
    end

    Setting.transaction do
      [
        self.set('discovery_fact_column', _("Show fact as an extra column in the discovered hosts list"), ""),
      ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
    end

    if SETTINGS[:locations_enabled]
      Setting.transaction do
        [
          self.set('discovery_location', _("The default location to place discovered hosts in"), ""),
        ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
      end
    end
    if SETTINGS[:organizations_enabled]
      Setting.transaction do
        [
          self.set('discovery_organization', _("The default organization to place discovered hosts in"), "" ),
        ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
      end
    end

    true

  end

end
