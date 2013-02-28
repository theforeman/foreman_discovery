module HostDiscoveredHelpers

  def disc_report_column(record)
    return record.last_report? ? time_ago_in_words(record.last_report.getlocal) +" ago": ""
  end

end
