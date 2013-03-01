Deface::Override.new(:virtual_path => "layouts/application", 
                     :name => "remove_topbar",
                     :surround => "code[erb-loud]:contains('home/topbar')",
                     :text => "<% unless request.fullpath =~ /^\\/discovered/ -%><%= render_original %><% end -%>")
