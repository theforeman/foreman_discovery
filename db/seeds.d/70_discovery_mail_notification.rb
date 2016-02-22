discovery_mail_notification = {
    :name => :discovered_summary,
    :description => N_('A summary of discovered hosts'),
    :mailer => 'DiscoveredMailer',
    :method => 'discovered_summary',
    :subscription_type => 'report',
}

MailNotification.where(discovery_mail_notification).first_or_create
