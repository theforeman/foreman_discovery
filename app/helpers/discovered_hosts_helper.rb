module DiscoveredHostsHelper
  def attach_flags(interface)
    flags = ""
    flags += "flag-primary " if interface[:primary]
    flags += "flag-provision" if interface[:provision]
    flags
  end

  def disc_report_column(record)
    record.last_report? ? date_time_relative(record.last_report.getlocal) : ""
  end

  def discovered_hosts_title_actions(host)
    actions =  [[_('Auto Provision'), hash_for_auto_provision_discovered_host_path(:id => host).merge(:auth_object => host, :permission => :auto_provision_discovered_hosts), :method => :post]]
    actions <<  [_('Refresh facts') ,hash_for_refresh_facts_discovered_host_path(:id => host).merge(:auth_object => host, :permission => :edit_discovered_hosts)]
    actions <<  [_('Reboot') ,hash_for_reboot_discovered_host_path(:id => host).merge(:auth_object => host, :permission => :edit_discovered_hosts), :method => :put]
    title_actions(
        button_group(
            link_to(_("Back"), :back, :class => "btn btn-default")
        ),
        select_action_button( _("Select Action"), {}, provision_button(host, hash_for_edit_discovered_host_path(:id => host)), actions.map { |action| display_link_if_authorized(action[0] , action[1], action[2] || {}) }.flatten ),
      button_group(
        display_delete_if_authorized(hash_for_discovered_host_path(:id => host).merge(:auth_object => host, :permission => :destroy_discovered_hosts), :class => "btn btn-default", :data => { :confirm => _('Delete %s?') % host.name })
      )
    )
  end

  def multiple_discovered_hosts_actions_select
    actions = [[_('Auto Provision'), multiple_auto_provision_discovered_hosts_path, hash_for_multiple_auto_provision_discovered_hosts_path]]
    actions <<  [_('Reboot'), multiple_reboot_discovered_hosts_path, hash_for_multiple_reboot_discovered_hosts_path]
    actions <<  [_('Assign Organization'), select_multiple_organization_discovered_hosts_path,  hash_for_select_multiple_organization_discovered_hosts_path]
    actions <<  [_('Assign Location'), select_multiple_location_discovered_hosts_path,  hash_for_select_multiple_location_discovered_hosts_path]
    actions <<  [_('Delete'), multiple_destroy_discovered_hosts_path, hash_for_multiple_destroy_discovered_hosts_path]

    select_action_button( _("Select Action"), {:id => 'submit_multiple'},
      actions.map do |action|
        link_to_function(action[0], "tfm.hosts.table.buildModal(this, '#{action[1]}')", :'data-dialog-title' => _("%s - The following hosts are about to be changed") % action[0]) if authorized_for(action[2])
      end.flatten
    )
  end

  def turn_zero_to_not_available(value)
    (value == 0) ? 'N/A' : value
  end

  def discovery_attribute(host, attr, default_value = _('N/A'))
    host.try(:discovery_attribute_set).try(attr) || default_value
  end

  def authorized_for_edit_destroy?
    authorized_for(:controller => :discovered_hosts, :action => :edit) or
        authorized_for(:controller => :discovered_hosts, :action => :destroy)
  end

  def discovery_status_icon(host)
    if host.created_at > 1.day.ago
      status_glyph = 'pficon-on-running'
      status_message = _('New in the last 24 hours')
      status_color = '#0088ce'
    elsif host.last_report.present? && host.last_report < 7.days.ago
      status_glyph = 'pficon-paused'
      status_message = _('Not reported in more than 7 days')
      status_color = '#ec7a08'
    else
      status_glyph = 'pficon-on'
      status_message = _('Reported in the last 7 days')
      status_color = '#72767b'
    end

    "<span class='glyphicon #{status_glyph}' style='color: #{status_color}'
      title='#{status_message}'></span>".html_safe
  end

  def host_taxonomy_select(f, taxonomy)
    # Add hidden field with taxonomy value to be updated by the form on submit
    tax_html = super
    tax_id = "#{taxonomy.to_s.downcase}_id"
    selected_taxonomy = params[:host][tax_id] if params[:host]
    if @override_taxonomy && selected_taxonomy
      hidden_tax = f.hidden_field tax_id.to_sym, :value => selected_taxonomy
      tax_html += hidden_tax
    end
    tax_html
  end

  def provision_button(host, authorization_options)
    return '' unless authorized_for(authorization_options)

    link_to(
        _('Provision'), "#",
        :data => {
            :toggle => 'modal',
            :target => "#fixedPropertiesSelector-#{host.id}"})
  end

  def host_path(host)
    return discovered_host_path(host) if controller_name == 'discovered_hosts'
    # This is a hack to fix the hostgroup selection on the discovered host edit page
    # The hostgroup onChange action is replacing the form url from `/discovered_hosts/:id`
    # to `/hosts/:id``, which is not correct (in this case) and it breaks the form submission
    return discovered_host_path(host) if controller_name == 'hosts' &&
                                         action_name == 'process_hostgroup' &&
                                         Host::Discovered.find_by(id: host[:id])

    super
  end

  def discovery_doc_version
    Foreman::Plugin.find(:foreman_discovery).version.scan(/\d+\.\d+/).first
  end
end
