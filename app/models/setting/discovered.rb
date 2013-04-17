class Setting::Discovered < ::Setting

  def self.load_defaults
    # Check the table exists
    return unless super

    if SETTINGS[:locations_enabled]
      Setting.transaction do
        [
          self.set('discovery_location', "The default Location to place Discovered Hosts in", Location.first.name ),
        ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
      end
    end
    if SETTINGS[:organizations_enabled]
      Setting.transaction do
        [
          self.set('discovery_organization', "The default Organization to place Discovered Hosts in", Organization.first.name ),
        ].compact.each { |s| self.create s.update(:category => "Setting::Discovered")}
      end
    end

    true

  end

end
