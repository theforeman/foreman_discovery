class DiscoveredMailer < ::ApplicationMailer
  helper :discovered_hosts
  def discovered_summary(options = {})
    raise ::Foreman::Exception.new(N_("Must specify a user with email enabled")) unless (user = User.find(options[:user])) && user.mail_enabled?
    begin
      Time.zone = user.timezone
    rescue ArgumentError
      Time.zone = 'UTC'
    end

    set_url
    @time = options[:time] || 1.day.ago
    @discovered_hosts = Host::Discovered.authorized_as(user, :view_discovered_hosts, Host::Discovered).where("created_at >= ?", @time)
    set_locale_for(user) do
      subject = _("Discovered hosts summary")
      mail(:to => user.mail, :subject => subject)
    end
  end
end
