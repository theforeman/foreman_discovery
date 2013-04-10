module DiscoveryHomeHelperPatch
  def self.included(base)
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :setting_options, :discovered_link
    end
  end

  module InstanceMethods
    # Adds a discovered link to the More menu
    def setting_options_with_discovered_link
      choices = setting_options_without_discovered_link
      choices += [
        [:divider],
        ['Discovered', :discovered]
      ]
      authorized_menu_actions(choices)
    end
  end
end
