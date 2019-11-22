module Host::ManagedExtensions
  extend ActiveSupport::Concern

  included do
    # execute standard callbacks
    after_validation :queue_reboot
    after_save :delete_discovery_attribute_set, :update_notifications

    belongs_to :discovery_rule

    scoped_search :relation => :discovery_rule, :on => :name, :rename => :discovery_rule, :complete_value => true, :only_explicit => true
  end

  def queue_reboot
    unless errors.empty? && Setting[:discovery_reboot]
      logger.warn("Not queueing Discovery reboot: #{errors.full_messages.to_sentence}")
      return
    end
    return if new_record? # Discovered Hosts already exist, and new_records will break `find`
    return unless will_save_change_to_attribute?(:type, from: 'Host::Discovered')
    # reboot task must be high priority and there is no compensation action apparently
    if facts['discovery_kexec'] && provisioning_template(:kind => 'kexec')
      post_queue.create(:name => _("Reloading kernel on %s") % self, :priority => 10000, :action => [self, :setKexec])
    else
      post_queue.create(:name => _("Rebooting %s") % self, :priority => 10000, :action => [self, :setReboot])
    end
  end

  def setReboot
    old.becomes(Host::Discovered).reboot(facts["discovery_bootip"] || facts["ipaddress"])
    # It is too late to report error in the post_queue, we catch them and
    # continue. If flash is implemented for new hosts (http://projects.theforeman.org/issues/10559)
    # we can report the error to the user perhaps.
    true
  rescue ::Foreman::Exception => e
    Foreman::Logging.exception("Unable to reboot", e)
    true
  end

  def delReboot
    # no reboot on orchestration rollback
  end

  def render_kexec_template
    template = provisioning_template(:kind => 'kexec')
    raise ::Foreman::Exception.new(N_("Kexec template not associated with operating system")) unless template

    json = JSON.parse(render_template(template: template))
    ::Foreman::Exception.new(N_("Kernel kexec URL is invalid: '%s'"), json['kernel']) unless json['kernel'] =~ /\Ahttp.+\Z/
    ::Foreman::Exception.new(N_("Init RAM kexec URL is invalid: '%s'"), json['initrd']) unless json['initrd'] =~ /\Ahttp.+\Z/
    json
  rescue StandardError => e
    Foreman::Logging.exception("Unable render or parse kexec template, must be valid JSON", e)
    {status: "Unable to render or parse template: " + e.to_s}
  end

  def setKexec
    old.becomes(Host::Discovered).kexec(render_kexec_template.to_json)
    true
  rescue ::Foreman::Exception => e
    Foreman::Logging.exception("Unable to kexec", e)
    true
  end

  def delKexec
    # no kexec on orchestration rollback
  end

  def delete_discovery_attribute_set
    return if new_record?

    DiscoveryAttributeSet.where(:host_id => self.id).destroy_all if saved_change_to_attribute?(:type) && type_previously_changed?
  end

  def update_notifications
    return if new_record?
    return unless saved_change_to_attribute?(:type) || type_previously_changed?

    ForemanDiscovery::UINotifications::DestroyHost.deliver!(self)
  end
end
