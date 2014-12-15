module DiscoveredHostsHelper

  def disc_report_column(record)
    record.last_report? ? (_("%s ago") % time_ago_in_words(record.last_report.getlocal)) : ""
  end

  def discovered_hosts_title_actions(host)
    title_actions(
      button_group(
        link_to(_("Provision"), hash_for_edit_discovered_host_path(:id => host), :class => 'btn-primary')
      ),
      button_group(
        link_to(_("Auto Provision"), hash_for_auto_provision_discovered_host_path(:id => host), :method => :post)
      ),
      button_group(
        link_to(_("Refresh facts"), hash_for_refresh_facts_discovered_host_path(:id => host))
      ),
      button_group(
        link_to(_("Delete"), hash_for_discovered_host_path(:id => host),
                :class => "btn btn-danger", :confirm => _('Are you sure?'), :method => :delete)
      )
    )
  end

  def multiple_discovered_hosts_actions_select
    actions = [[_('Delete hosts'), multiple_destroy_discovered_hosts_path]]
    actions <<  [_('Assign Organization'), select_multiple_organization_discovered_hosts_path] if SETTINGS[:organizations_enabled]
    actions <<  [_('Assign Location'), select_multiple_location_discovered_hosts_path] if SETTINGS[:locations_enabled]

    select_action_button( _("Select Action"), {:id => 'submit_multiple'},
      actions.map do |action|
        link_to(action[0] , action[1], :'data-dialog-title' => _("%s - The following hosts are about to be changed") % action[0])
      end.flatten
    )

  end

end
