class ChangeDiscoveryWidgetNames < ActiveRecord::Migration[4.2]
  def up
    Widget.where(:name => 'Discovery widget').\
      update_all(:name => 'Discovered Hosts')
  end

  def down
    Widget.where(:name => 'Discovered Hosts').\
      update_all(:name => 'Discovery widget')
  end
end
