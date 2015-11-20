module Host::ManagedExtensions
  extend ActiveSupport::Concern

  included do
    # execute standard callbacks
    after_validation :queue_reboot
    after_save :delete_discovery_attribute_set

    belongs_to :discovery_rule

    # extra flag for post_queue callbacks which has no access to facts
    attr_accessor :legacy_api
    attr_accessible :discovery_rule_id
  end

  def queue_reboot
    return unless errors.empty? && Setting[:discovery_reboot]
    return if new_record? # Discovered Hosts already exist, and new_records will break `find`
    return unless type_changed? and ::Host::Base.find(self.id).type == "Host::Discovered"
    # reboot task must be high priority and there is no compensation action apparently
    if facts['discovery_kexec'] && provisioning_template(:kind => 'kexec')
      post_queue.create(:name => _("Reloading kernel on %s") % self, :priority => 10000, :action => [self, :setKexec])
    else
      post_queue.create(:name => _("Rebooting %s") % self, :priority => 10000, :action => [self, :setReboot])
    end
  end

  def setReboot
    old.becomes(Host::Discovered).reboot legacy_api
    # It is too late to report error in the post_queue, we catch them and
    # continue. If flash is implemented for new hosts (http://projects.theforeman.org/issues/10559)
    # we can report the error to the user perhaps.
    true
  rescue ::Foreman::Exception
    true
  end

  def boot_url pxe_file
    raise ::Foreman::Exception.new(N_("Operating system not set for host/hostgroup")) unless operatingsystem
    base = operatingsystem.medium_uri(self)
    raise ::Foreman::Exception.new(N_("Medium not set for host/hostgroup")) unless base
    path = operatingsystem.url_for_boot(pxe_file)
    operatingsystem.medium_vars_to_uri("#{base}/#{path}", architecture.name, operatingsystem).to_s
  end

  def setKexec
    template = provisioning_template(:kind => 'kexec')
    raise ::Foreman::Exception.new(N_("Kexec template not associated with operating system")) unless template
    @host = self
    @kernel = boot_url(:kernel)
    @initrd = boot_url(:initrd)
    json = unattended_render(template)
    old.becomes(Host::Discovered).kexec json
    true
  rescue ::Foreman::Exception
    true
  end

  def delete_discovery_attribute_set
    return if new_record?
    DiscoveryAttributeSet.destroy_all(:host_id => self.id) if type_changed?
  end

end
