module Foreman::Controller::DiscoveredExtensions
  extend ActiveSupport::Concern

  # return auto provision rule or false when not present
  def find_discovery_rule host
    raise(::Foreman::Exception.new(N_("Unable to find a discovery rule, no host provided (check permissions)"))) if host.nil?
    Rails.logger.debug "Finding auto discovery rule for host #{host.name} (#{host.id})"
    # for each discovery rule ordered by priority
    DiscoveryRule.where(:enabled => true).order(:priority).each do |rule|
      max = rule.max_count
      usage = rule.hosts.size
      Rails.logger.debug "Found rule #{rule.name} (#{rule.id}) [#{usage}/#{max}]"
      # if the rule has free slots
      if max == 0 || usage < max
        # try to match the search
        begin
          if Host::Discovered.where(:id => host.id).search_for(rule.search).size > 0
            if validate_rule_by_taxonomy(rule, host)
              Rails.logger.info "Match found for host #{host.name} (#{host.id}) rule #{rule.name} (#{rule.id})"
              return rule
            else
              Rails.logger.warn "Rule #{rule.name} (#{rule.id}) can not be applied due to a difference in organization/location from host #{host.name} (#{host.id})"
            end
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

  def validate_rule_by_taxonomy rule, host
    if SETTINGS[:organizations_enabled]
      return false unless rule.organizations.include?(host.organization)
    end
    if SETTINGS[:locations_enabled]
      return false unless rule.locations.include?(host.location)
    end
    true
  end

  # trigger the provisioning
  def perform_auto_provision original_host, rule
    raise(::Foreman::Exception.new(N_("No hostgroup associated with rule '%s'"), rule)) if rule.hostgroup.nil?
    Host.transaction do
      host = ::ForemanDiscovery::HostConverter.to_managed(original_host)
      host.hostgroup_id = rule.hostgroup_id
      host.comment = "Auto-discovered and provisioned via rule '#{rule.name}'"
      host.discovery_rule = rule
      # render hostname only when all other fields are set
      original_name = host.name
      host.name = host.render_template(rule.hostname) unless rule.hostname.empty?
      # fallback to the original if template did not expand
      host.name = original_name if host.name.empty?
      # save! does not work here
      host.save
    end
  end

  def perform_reboot_all hosts = Host::Discovered.all
    result = true
    error_message = _("Errors during reboot: %s")
    overall_errors = ""

    if hosts.count > 0
      Host.transaction do
        hosts.each do |discovered_host|
          begin
            unless discovered_host.reboot
              error =  "#{discovered_host.name}: failed to reboot "
              overall_errors << error
              logger.error error
            end
          rescue Exception => e
            error = "#{discovered_host.name}: #{e.to_s} "
            overall_errors << error
            logger.error error
          end
        end
      end
    else
      error_message = _("No discovered hosts to reboot")
      result = false
    end

    if overall_errors.present? || !result
      error_message % overall_errors.strip
    end
  end

end
