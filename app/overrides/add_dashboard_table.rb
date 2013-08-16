Deface::Override.new(:virtual_path => "dashboard/_status_table",
                     :name => "add_dashboard_table",
                     :insert_after => "ul:last",
                   :text => ("
<h4 class='header'><%= _('Host Pool') %></h4>
<ul>
  <li>
    <%= link_to(_('Unassigned hosts'), discovers_path, :class=>'dashboard-links' ) %>
    <h4><%= Host::Discovered.count %></h4>
  </li>
</ul>"))

# strings used above, for the purposes of extraction only, as they're not
# detected within the full override template string above
N_('Host Pool')
N_('Unassigned hosts')
