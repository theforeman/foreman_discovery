class ChangeErrorExistingSetting < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up do
        Setting[:discovery_action_on_existing] = "Error" if Setting[:discovery_error_on_existing]
        Setting.find_by_name("discovery_error_on_existing").try(:destroy)
      end
      dir.down do
        Setting.find_by_name("discovery_error_on_existing").try(:destroy)
        Setting.find_by_name("discovery_action_on_existing").try(:destroy)
      end
    end
  end
end
