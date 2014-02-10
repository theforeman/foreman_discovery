class Setting::Discovered < ::Setting
  BLANK_ATTRS << "discovery_location"
  BLANK_ATTRS << "discovery_location_fact"
  BLANK_ATTRS << "discovery_organization"
  BLANK_ATTRS << "discovery_organization_fact"

  def self.load_defaults
    # Check the table exists
    return unless super

    Setting.transaction do
      [
        self.set('discovery_fact', _("The default fact name to use for the MAC of the system"), "macaddress"),
        self.set('discovery_hostname_fact', _("The default fact name to use for the hostname of the system"), "macaddress"),
      ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
    end

    if SETTINGS[:locations_enabled]
      Setting.transaction do
        [
          self.set('discovery_location', _("The default location to place discovered hosts in"), ""),
          self.set('discovery_location_fact', _("The default location fact name to use for the Location of the system"), ""),
        ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
      end
    end
    if SETTINGS[:organizations_enabled]
      Setting.transaction do
        [
          self.set('discovery_organization', _("The default organization to place discovered hosts in"), "" ),
          self.set('discovery_organization_fact', _("The default organization fact name to use for the Organization of the system"), "" ),
        ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
      end
    end

    true

  end

end
