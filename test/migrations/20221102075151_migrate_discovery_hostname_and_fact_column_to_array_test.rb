require_relative '../test_plugin_helper'
require ForemanDiscovery::Engine.root.join('db/migrate/20221102075151_migrate_discovery_hostname_and_fact_column_to_array')

class MigrateDiscoveryHostnameAndFactColumnToArrayTest < ActiveSupport::TestCase
  let(:migrations_paths) { ActiveRecord::Migrator.migrations_paths + [ForemanDiscovery::Engine.root.join('db/migrate/').to_s] }

  let(:previous_version) { '20221102065954'.to_i }
  let(:current_version) { '20221102075151'.to_i }

  #only load the two migrations we care about (previous one and current one)
  let(:migrations) do
    [
      ActiveRecord::MigrationProxy.new("FixDiscoverySettingsCategoryToDsl", previous_version, "#{ForemanDiscovery::Engine.root}/db/migrate/20221102065954_fix_discovery_settings_category_to_dsl.rb", ""),
      ActiveRecord::MigrationProxy.new("MigrateDiscoveryHostnameAndFactColumnToArray", current_version, "#{ForemanDiscovery::Engine.root}/db/migrate/20221102075151_migrate_discovery_hostname_and_fact_column_to_array.rb", "")
    ]
  end

  def migrate_up
    ActiveRecord::Migrator.new(:up, migrations, ActiveRecord::SchemaMigration, current_version).migrate
  end

  def setup
    ActiveRecord::Migration.suppress_messages do
      ActiveRecord::Migrator.new(:down, migrations, ActiveRecord::SchemaMigration, previous_version).migrate
    end
  end

  def setup_setting(name, value)
    setting = Setting.find_or_create_by(name: name)
    setting.value = value
    setting.save(validate: false)
  end

  def test_discovery_hostname_string
    setup_setting('discovery_hostname', 'discovery_bootif')
    migrate_up
    assert_equal ['discovery_bootif'], Setting['discovery_hostname']
  end

  def test_discovery_hostname_multistring
    setup_setting('discovery_hostname', 'discovery_bootif, fqdn')
    migrate_up
    assert_equal ['discovery_bootif', 'fqdn'], Setting['discovery_hostname']
  end

  def test_discovery_hostname_array
    Setting['discovery_hostname'] = ['discovery_bootif']
    migrate_up
    assert_equal ['discovery_bootif'], Setting['discovery_hostname']
  end

  def test_discovery_fact_column_empty
    setup_setting('discovery_fact_column', '')
    migrate_up
    assert_equal [], Setting['discovery_fact_column']
  end

  def test_discovery_fact_column_string
    setup_setting('discovery_fact_column', 'bios_vendor')
    migrate_up
    assert_equal ['bios_vendor'], Setting['discovery_fact_column']
  end

  def test_discovery_fact_column_multistring
    setup_setting('discovery_fact_column', 'bios_vendor, fqdn')
    migrate_up
    assert_equal ['bios_vendor', 'fqdn'], Setting['discovery_fact_column']
  end

  def test_discovery_fact_column_array
    Setting['discovery_fact_column'] = ['bios_vendor']
    migrate_up
    assert_equal ['bios_vendor'], Setting['discovery_fact_column']
  end
end
