# frozen_string_literal: true

class MigrateDiscoveryHostnameAndFactColumnToArray < ActiveRecord::Migration[6.0]
  def up
    ['discovery_hostname', 'discovery_fact_column'].each do |setting_name|
      setting = Setting.find_by(name: setting_name)
      if !setting.nil? && setting.value.is_a?(String)
        setting.value = setting.value.split(",").map(&:strip)
        setting.save
      end
    end
  end
end
