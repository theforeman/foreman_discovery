module DiscoveryRulesHelper
  def search_path(type)
    if type.nil?
      ''
    else
      case type
        when 'Image'
          '' # images are nested resource for CR, we can't autocomplete
        when 'HostClass'
          '' # host classes is only used in API
        when 'Parameter'
          '' # parameter is only used in API
        else
          return FiltersHelperOverrides.search_path(type) if FiltersHelperOverrides.can_override?(type)
          resource_path = resource_path(type)
          resource_path.nil? ? "" : resource_path + auto_complete_search_path
      end
    end
  end

  def auto_complete_search_path
    '/auto_complete_search'
  end

  def permitted_discovery_actions(rule)
    actions = [display_link_if_authorized(_('Discovered Hosts'), hash_for_discovered_hosts_path.merge(:search => rule.search))]
    actions << display_link_if_authorized(_('Associated Hosts'), hash_for_hosts_path.merge(:search => "discovery_rule = \"#{rule.name}\""))
    if rule.enabled?
      actions << display_link_if_authorized(_('Disable'), hash_for_disable_discovery_rule_path(:id => rule).merge(:auth_object => rule, :authorizer => authorizer), :confirm => _("Disable rule '%s'?") % rule)
    else
      actions << display_link_if_authorized(_('Enable'), hash_for_enable_discovery_rule_path(:id => rule).merge(:auth_object => rule, :authorizer => authorizer), :confirm => _("Enable rule '%s'?") % rule)
    end
    actions << display_delete_if_authorized(hash_for_discovery_rule_path(:id => rule).merge(:auth_object => rule, :authorizer => authorizer), :confirm => _("Delete rule '%s'?") % rule)
  end
end
