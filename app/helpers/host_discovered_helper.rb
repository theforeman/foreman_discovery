module HostDiscoveredHelper

  def disc_report_column(record)
    return record.last_report? ? time_ago_in_words(record.last_report.getlocal) +" ago": ""
  end

  def disc_host_title_actions(host)
    title_actions(
      button_group(
        link_to("Refresh Facts", hash_for_refresh_facts_path(:id => host)),
        link_to("Provision", hash_for_disc_convert_path(:id => host))
    ),
      button_group(
        link_to_if_authorized("Delete", hash_for_host_path(:id => host, :auth_action => :destroy),
                              +                              :class => "btn btn-danger", :confirm => 'Are you sure?', :method => :delete)
    )
    )
  end

end
