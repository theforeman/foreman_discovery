# This calls the main test_helper in Foreman-core
require 'test_helper'
require 'test_helper_discovery'

# Add plugin to FactoryGirl's paths
FactoryGirl.definition_file_paths << File.join(File.dirname(__FILE__), 'factories')
FactoryGirl.reload
# load notification seeds.
require File.join(
  File.dirname(__FILE__), '..', 'db', 'seeds.d', '80_discovery_ui_notification'
)
