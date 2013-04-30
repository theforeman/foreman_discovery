class Setting::Discovered < ::Setting
  BLANK_ATTRS << "discovery_location"
  BLANK_ATTRS << "discovery_organization"

  def self.load_defaults
    # Check the table exists
    return unless super

    if SETTINGS[:locations_enabled]
      Setting.transaction do
        [
          self.set('discovery_location', "The default Location to place Discovered Hosts in", ""),
        ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
      end
    end
    if SETTINGS[:organizations_enabled]
      Setting.transaction do
        [
          self.set('discovery_organization', "The default Organization to place Discovered Hosts in", "" ),
        ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
      end
    end

    true

  end

end
