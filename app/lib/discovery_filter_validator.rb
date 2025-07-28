class DiscoveryFilterValidator < ActiveModel::Validator
  # Users can assign a search filter to a discovered host that is valid
  # only for the Host model, but not for the Host::Discovered model.
  # For example, the 'hostgroup' field is valid for Host, but not for Host::Discovered.
  def validate(record)
    return if record.search.blank?

    has_permission = record.permissions.find { |perm| perm.name == 'view_discovered_hosts' }

    return unless has_permission

    begin
      Host::Discovered.search_for(record.search)
    rescue ScopedSearch::QueryNotSupported => _e
      msg = N_("Search filter is invalid: Field 'search' is not recognized for Discovered hosts.")
      record.errors.add(:search, msg)
    end
  end
end
