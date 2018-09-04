# lock the host into discovery via PXE if feature is enabled in settings
module ForemanDiscovery
  module ImportHooks
    class LockTemplates < ImportHook
      def after_populate
        lock_templates if Setting::Discovered.discovery_lock? && host.subnet.tftp?
      end

      def lock_templates
        TemplateKind::PXE.each do |kind|
          setting = "discovery_#{kind.downcase}_lock_template"
          template_name = Setting[setting]
          logger.info "Locking discovered host #{host.mac} in subnet #{host.subnet} via #{template_name} template"
          template = ::ProvisioningTemplate.unscoped.find_by_name(template_name)
          if template.nil?
            logger.warn "Template '#{template_name}' provided by setting '#{setting}' does not exist, not locking"
            next
          end
          rendered_template = host.render_template(template: template, params: { host: host })
          host.subnet.tftp_proxy.set(kind, host.mac, pxeconfig: rendered_template)
        end
      rescue ::Foreman::Exception => e
        ::Foreman::Logging.exception('Could not set tftp_proxy from proxy', e)
      end
    end
  end
end
