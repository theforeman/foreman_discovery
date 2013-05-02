Deface::Override.new(:virtual_path => "dashboard/_status_table",
                     :name => "add_dashboard_table",
                     :insert_after => "ul:last",
                   :text => '
<h4 class="header"><%= "Host Pool" -%></h4>
<ul>
  <li>
    <%= link_to("Unassigned Hosts", discovers_path, :class=>"dashboard-links" ) %>
    <h4><%= Host::Discovered.count %></h4>
  </li>
</ul>')
