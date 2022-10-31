class Setting::Discovered
  def self.discovery_fact_column_array
    from_array(Setting['discovery_fact_column'])
  end

  def self.discovery_hostname_fact_array
    return [] if !Setting['discovery_hostname'].present?
    from_array Setting['discovery_hostname']
  end

  def self.from_array(setting)
    return [] unless setting.present?
    setting.to_s.split(",").map(&:strip)
  rescue Exception => e
    logger.warn "Failed to parse discovery_fact_column, ignoring: #{e}"
    []
  end
end
