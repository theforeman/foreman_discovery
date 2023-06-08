class ForemanDiscovery::HostFactImporter < HostFactImporter
  def import_facts(facts)
    # Discovered Hosts won't report in via puppet, so we can use that field to
    # record the last time it sent facts...
    host.last_report = Time.now
    # Set the correct facts type for new foreman facts importing code.
    facts[:_type] = :foreman_discovery
    super(facts)
  end
end
