Deface::Override.new(:virtual_path => "hosts/_operating_system", 
                     :name => "add_build_flag",
                     :insert_after => "span[id='os_select']",
                     :text => "\n<% if request.fullpath =~ /^\\/discovers/ -%><%= f.hidden_field :build, :value => true %><% end -%>")
