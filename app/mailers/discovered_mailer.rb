class DiscoveredMailer < ApplicationMailer
  helper :discovered_hosts
  def discovered_summary(options = {})
    user = if options[:user].kind_of? User
             options[:user]
           elsif options[:user].kind_of? Integer
             User.find(options[:user])
           else
             raise ::Foreman::Exception.new(N_('Invalid user type of %s was provided'), options[:user].class.to_s)
           end

    unless user.mail_enabled?
      Rails.logger.debug { "The user #{user.id} does not email enabled" }
      return
    end
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
