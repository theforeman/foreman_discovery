module DiscoveredHelper

  def disc_report_column(record)
    return record.last_report? ? time_ago_in_words(record.last_report.getlocal) +" ago": ""
  end

  def discovered_title_actions(host)
    title_actions(
      button_group(
        link_to('Back to Discovered', '/discovered/', :class => 'btn-primary')
    ),
      button_group(
        link_to("Refresh Facts", hash_for_refresh_facts_path(:id => host)),
        link_to("Provision", hash_for_edit_discovered_path(:id => host)),
        link_to("Delete", hash_for_discovered_path(:id => host),
                :class => "btn btn-danger", :confirm => 'Are you sure?', :method => :delete)
    )
    )
  end

end
