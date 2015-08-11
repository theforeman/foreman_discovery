kind = TemplateKind.find_or_create_by_name('kexec')

ProvisioningTemplate.without_auditing do
  content = File.read(File.join(ForemanDiscovery::Engine.root, 'app', 'views', 'foreman_discovery', 'redhat_kexec.erb'))
  tmpl = ProvisioningTemplate.find_or_create_by_name(
    :name => 'Discovery Red Hat kexec',
    :template_kind_id => kind.id,
    :snippet => false,
    :template => content
  )
  tmpl.attributes = {
    :template => content,
    :default  => true,
    :vendor   => "Foreman Discovery",
    :locked   => false
  }
  tmpl.save!(:validate => false) if tmpl.changes.present?
end
