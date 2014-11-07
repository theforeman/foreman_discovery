require 'foreman_discovery/engine'

module ForemanDiscovery
  def self.execute_auto_provisioning dhost=nil
    if dhost
      Rails.logger.debug "Executing discovery rules for host #{dhost.name} (#{dhost.id})"
      # for each discovery rule ordered by priority
      DiscoveryRule.where(:enabled => true).order(:priority).each do |rule|
        max = rule.max_count
        usage = rule.hosts.size
        Rails.logger.debug "Applying rule #{rule.name} (#{rule.id}) [#{usage}/#{max}]"
        # if the rule has free slots
        if max == 0 || usage < max
          # try to match the query
          if Host::Discovered.where(:id => dhost.id).search_for(rule.query).size > 0
            Rails.logger.info "Match found for host #{dhost.name} (#{dhost.id}) rule #{rule.name} (#{rule.id})"
            dhost = dhost.becomes(::Host::Managed)
            dhost.type = 'Host::Managed'
            dhost.managed = true
            dhost.build = true
            #dhost.name = XXX
            dhost.hostgroup_id = rule.hostgroup_id
            dhost.comment = "Auto-discovered and provisioned via rule '#{rule.name}'"
            dhost.save!
            break
          end
        else
          Rails.logger.info "Skipping drained rule #{rule.name} (#{rule.id}) with max set to #{rule.max_count}"
        end
      end
      return true
    else
      # For each discovered host
      Host::Discovered.order(:last_report).each do |discovered_host|
        execute_auto_provisioning discovered_host
      end
    end
  end
end
