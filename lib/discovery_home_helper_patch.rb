module DiscoveryHomeHelperPatch
  def self.included(base)
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :settings_menu_items, :discovers_link
    end
  end

  module InstanceMethods
    # Adds a discovers link to the More menu
    def settings_menu_items_with_discovers_link
      menu_items = settings_menu_items_without_discovers_link
      menu_items[2][2].insert(2,[_('Discovered Hosts'), :discovers]) if menu_items[2]
      menu_items
    end
  end
end
