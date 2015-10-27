kind = TemplateKind.where(:name => 'kexec').first_or_create

ProvisioningTemplate.without_auditing do
  content = File.read(File.join(ForemanDiscovery::Engine.root, 'app', 'views', 'foreman_discovery', 'redhat_kexec.erb'))
  tmpl = ProvisioningTemplate.where(:name => 'Discovery Red Hat kexec').first_or_create(
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
