module Foreman::Controller::DiscoveredExtensions
  extend ActiveSupport::Concern

  # return auto provision rule or false when not present
  def find_discovery_rule host
    raise(::Foreman::Exception.new(N_("Unable to find a discovery rule, no host provided (check permissions)"))) if host.nil?
    Rails.logger.debug "Finding auto discovery rule for host #{host.name} (#{host.id})"
    # rule with *lower* priority wins (older wins for same priority)
    DiscoveryRule.where(:enabled => true).reorder(:priority).each do |rule|
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
    return false unless rule.organizations.include?(host.organization)
    return false unless rule.locations.include?(host.location)
    true
  end

  # trigger the provisioning
  def perform_auto_provision original_host, rule
    raise(::Foreman::Exception.new(N_("No hostgroup associated with rule '%s'"), rule)) if rule.hostgroup.nil?

    logger.debug "Auto-provisioning via rule #{rule} hostgroup #{rule.hostgroup} subnet #{rule.hostgroup.subnet}"
    host = ::ForemanDiscovery::HostConverter.to_managed(original_host)
    host.hostgroup_id = rule.hostgroup_id
    host.comment = "Auto-discovered and provisioned via rule '#{rule.name}'"
    host.discovery_rule = rule
    # render hostname only when all other fields are set
    original_name = host.name
    source = Foreman::Renderer::Source::String.new(name: 'Hostname template', content: rule.hostname)
    scope = Foreman::Renderer.get_scope(host: host, source: source)
    host.name = Foreman::Renderer.render(source, scope)
    # fallback to the original if template did not expand
    host.name = original_name if host.name.empty?
    # explicitly set all inheritable attributes from hostgroup
    host.attributes = host.apply_inherited_attributes(hostgroup_id: rule.hostgroup_id)
    host.set_hostgroup_defaults
    # change subnet and fetch unused IPs
    ::ForemanDiscovery::HostConverter.unused_ip_for_host(host, rule.hostgroup.subnet, rule.hostgroup.subnet6)
    # save! does not work here
    if host.save
      host
    else
      Rails.logger.error "Auto provisioning failed: #{host.errors.full_messages.to_sentence}"
      false
    end
  end

  def perform_reboot_all hosts = Host::Discovered.all
    overall_errors = []

    if hosts.count > 0
      hosts.each do |discovered_host|
        begin
          unless discovered_host.reboot
            msg = "#{discovered_host.name}: Failed to reboot "
            e = Excpetion.New()
            overall_errors << WrappedException.new(e, msg)
            logger.error e.message
          end
        rescue Exception => e
          overall_errors << e
          logger.error e.message
        end
      end
    else
      msg = _("No discovered hosts to reboot")
      overall_errors << WrappedException.new(Exception.new(), msg)
    end
    overall_errors
  end

end
