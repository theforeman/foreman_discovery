module DiscoveredHostsHelper

  def attach_flags(interface)
    flags = ""
    flags += "flag-primary " if interface[:primary]
    flags += "flag-provision" if interface[:provision]
    flags
  end

  def disc_report_column(record)
    record.last_report? ? (_("%s ago") % time_ago_in_words(record.last_report.getlocal)) : ""
  end

  def discovered_hosts_title_actions(host)
    actions = [[_('Provision'),  hash_for_edit_discovered_host_path(:id => host)]]
    actions <<  [_('Auto Provision'), hash_for_auto_provision_discovered_host_path(:id => host), :method => :post]
    actions <<  [_('Refresh facts') ,hash_for_refresh_facts_discovered_host_path(:id => host)]
    actions <<  [_('Reboot') ,hash_for_reboot_discovered_host_path(:id => host), :method => :put]
    title_actions(
        button_group(
            link_to(_("Back"), :back)
        ),
        select_action_button( _("Select Action"), {},
                              actions.map do |action|
                                method = action[2] if action.size > 1
                                link_to(action[0] , action[1], method)
                              end.flatten
        ),
      button_group(
        link_to(_("Expand All"),"#",:class => "btn ",:onclick => "$('.glyphicon-plus-sign').toggleClass('glyphicon glyphicon-minus-sign glyphicon glyphicon-plus-sign');
                $('.facts-panel').addClass('collapse in').height('auto');"
        )
      ),
      button_group(
        link_to(_("Delete"), hash_for_discovered_host_path(:id => host),
                :class => "btn btn-danger", :confirm => _('Are you sure?'), :method => :delete)
      )
    )
  end

  def multiple_discovered_hosts_actions_select
    actions = [[_('Delete hosts'), multiple_destroy_discovered_hosts_path, hash_for_multiple_destroy_discovered_hosts_path]]
    actions <<  [_('Assign Organization'), select_multiple_organization_discovered_hosts_path,  hash_for_select_multiple_organization_discovered_hosts_path] if SETTINGS[:organizations_enabled]
    actions <<  [_('Assign Location'), select_multiple_location_discovered_hosts_path,  hash_for_select_multiple_location_discovered_hosts_path] if SETTINGS[:locations_enabled]

    select_action_button( _("Select Action"), {:id => 'submit_multiple'},
      actions.map do |action|
        link_to_function(action[0], "build_modal(this, '#{action[1]}')", :'data-dialog-title' => _("%s - The following hosts are about to be changed") % action[0]) if authorized_for(action[2])
      end.flatten
    )
  end

  def turn_zero_to_not_available(value)
    value == 0 ? 'N/A' : value
  end

  def discovery_attribute(host, attr, default_value = _('N/A'))
    host.try(:discovery_attribute_set).try(attr) || default_value
  end

  def authorized_for_edit_destroy?
    authorized_for(:controller => :discovered_hosts, :action => :edit) or
        authorized_for(:controller => :discovered_hosts, :action => :destroy)
  end

  def discovery_status_icon(host)
    if host.created_at > 1.day.ago
      status_glyph = 'glyphicon-plus-sign'
      status_message = _('New in the last 24 hours')
      status_color = '#89A54E'
    elsif host.last_report < 7.days.ago
      status_glyph = 'glyphicon-exclamation-sign'
      status_message = _('Not reported in more than 7 days')
      status_color = '#AA4643'
    else
      status_glyph = 'glyphicon-ok-sign'
      status_message = _('Reported in the last 7 days')
      status_color = '#4572A7'
    end

    "<span class='glyphicon #{status_glyph}' style='color: #{status_color}'
      title='#{status_message}'/>".html_safe
  end
end
