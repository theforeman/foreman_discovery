# requires the main test_helper from Foreman-core
require 'test_helper'
require_relative './test_helper_discovery'

# Add plugin to FactoryBot's paths
FactoryBot.definition_file_paths << File.join(File.dirname(__FILE__), 'factories')

# Add dependencies
if defined? ForemanPuppet
  FactoryBot.definition_file_paths << File.join("#{ForemanPuppet::Engine.root}/test", 'factories')
end

# And reload
FactoryBot.reload
