selector_text = " <%= select_f f, :discovery_id, SmartProxy.with_features('Discovery'), :id, :name,
                    {:include_blank => _('None')},
                    :label => _('Discovery Proxy'),
                    :help_inline => _('Discovery Proxy to use within this subnet for managing connection to discovered hosts') %>"

Deface::Override.new(:virtual_path  => "subnets/_form",
                     :name          => "add_discovery_proxy_to_subnet",
                     :insert_bottom => 'div#proxies',
                     :text          =>  selector_text)