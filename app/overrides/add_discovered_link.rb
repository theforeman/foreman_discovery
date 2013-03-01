Deface::Override.new(:virtual_path => "hosts/index", 
                     :name => "add_discovered_link",
                     :insert_after => "code[erb-silent]:contains('title_actions')",
                     :text => " <% title_actions link_to('Discovered', 'discovered/', :class => 'btn-primary') -%>")
