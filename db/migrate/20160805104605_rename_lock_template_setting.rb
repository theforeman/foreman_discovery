class RenameLockTemplateSetting < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        setting = Setting.find_by_name("discovery_lock_template")
        setting.destroy if setting
      end
      dir.down do
        setting = Setting.find_by_name("discovery_pxelinux_lock_template")
        setting.destroy if setting
      end
    end
  end
end
