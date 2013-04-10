module DiscoveryHomeHelperPatch
  def self.included(base)
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :setting_options, :discovers_link
    end
  end

  module InstanceMethods
    # Adds a discovers link to the More menu
    def setting_options_with_discovers_link
      choices = setting_options_without_discovers_link
      choices += [
        [:divider],
        ['Discovered', :discovers]
      ]
      authorized_menu_actions(choices)
    end
  end
end
