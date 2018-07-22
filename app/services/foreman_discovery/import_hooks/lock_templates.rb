# lock the host into discovery via PXE if feature is enabled in settings
module ForemanDiscovery
  module ImportHooks
    class LockTemplates < ImportHook
      def after_populate
        lock_templates if Setting::Discovered.discovery_lock? && host.subnet.tftp?
      end

      def lock_templates
        TemplateKind::PXE.each do |kind|
          template_name = Setting["discovery_#{kind.downcase}_lock_template"]
          logger.info "Locking discovered host #{host.mac} in subnet #{host.subnet} via #{template_name} template"
          template = ::ProvisioningTemplate.find_by_name(template_name)
          rendered_template = host.render_template(template: template, params: { host: host })
          host.subnet.tftp_proxy.set(kind, host.mac, pxeconfig: rendered_template)
        end
      rescue ::Foreman::Exception => e
        ::Foreman::Logging.exception('Could not set tftp_proxy from proxy', e)
      end
    end
  end
end
