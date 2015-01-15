module Foreman::Controller::DiscoveredExtensions
  extend ActiveSupport::Concern

  # return auto provision rule or false when not present
  def find_discovery_rule host
    Rails.logger.debug "Finding auto discovery rule for host #{host.name} (#{host.id})"
    # for each discovery rule ordered by priority
    DiscoveryRule.where(:enabled => true).order(:priority).each do |rule|
      max = rule.max_count
      usage = rule.hosts.size
      Rails.logger.debug "Found rule #{rule.name} (#{rule.id}) [#{usage}/#{max}]"
      # if the rule has free slots
      if rule.has_free_slots?
        # try to match the search
        begin
          if Host::Discovered.where(:id => host.id).search_for(rule.search).size > 0
            Rails.logger.info "Match found for host #{host.name} (#{host.id}) rule #{rule.name} (#{rule.id})"
            return rule
          end
        rescue ScopedSearch::QueryNotSupported => e
          Rails.logger.warn "Invalid query for rule #{rule.name} (#{rule.id}): #{e.message}"
        end
      else
        Rails.logger.info "Skipping drained rule #{rule.name} (#{rule.id}) with max set to #{rule.max_count}"
      end
    end
    return false
  end

  # trigger the provisioning
  def perform_auto_provision host, rule
    host = host.becomes(::Host::Managed)
    host.type = 'Host::Managed'
    host.managed = true
    host.build = true
    host.name = host.render_template(rule.hostname) unless rule.hostname.empty?
    host.hostgroup_id = rule.hostgroup_id
    host.comment = "Auto-discovered and provisioned via rule '#{rule.name}'"
    host.discovery_rule = rule
    Host.transaction do
      if host.save #save! does not work here
        delete_discovery_attribute_set(host.id)
      end
    end
  end

  # discovery_attribute_set should be deleted only after a host has been successfully provisioned
  # (after discovered host becomes managed host)
  # after this happens the host is a manged host so non of the callbacks in discovered hosts are relevant anymore
  # for this reason the orphaned discovery_attribute_set needs to be searched for and deleted
  def delete_discovery_attribute_set(host_id)
    DiscoveryAttributeSet.delete_all(:host_id => host_id)
  end

end
