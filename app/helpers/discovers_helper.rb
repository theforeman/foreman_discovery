module DiscoversHelper

  def disc_report_column(record)
    record.last_report? ? (_("%s ago") % time_ago_in_words(record.last_report.getlocal)) : ""
  end

  def discovers_title_actions(host)
    title_actions(
      button_group(
        link_to(_("Provision"), hash_for_edit_discover_path(:id => host), :class => 'btn-primary')
      ),
      button_group(
        link_to(_("Refresh facts"), hash_for_refresh_facts_discover_path(:id => host))
      ),
      button_group(
        link_to(_("Delete"), hash_for_discover_path(:id => host),
                :class => "btn btn-danger", :confirm => _('Are you sure?'), :method => :delete)
      )
    )
  end

  def multiple_discovers_actions_select
    actions = [[_('Delete hosts'), multiple_destroy_discovers_path, 'trash']]
    actions <<  [_('Assign Organization'), select_multiple_organization_discovers_path, 'tags'] if SETTINGS[:organizations_enabled]
    actions <<  [_('Assign Location'), select_multiple_location_discovers_path, 'map-marker'] if SETTINGS[:locations_enabled]

    content_tag :span, :id => 'submit_multiple' do
      select_action_button( _("Select action"), actions.map do |action|
        link_to(icon_text(action[2], action[0]) , action[1], :class=>'btn',  :title => _("%s - The following hosts are about to be changed") % action[0])
      end.flatten)
    end

  end

end
