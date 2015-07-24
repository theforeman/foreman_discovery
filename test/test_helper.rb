require 'rubygems'
require 'bundler/setup'

ENV["RAILS_ENV"] ||= 'test'

require 'test/unit'
require 'foreman_discovery'
require 'rails/test_help'

Rails.backtrace_cleaner.remove_silencers!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting

  foreman_dir =  File.expand_path("../../.foreman_app", File.join(Dir.pwd, __FILE__))
  fixture_path=File.join(foreman_dir, "test/fixtures")
  fixtures :all

  set_fixture_class({ :hosts => Host::Base })
end
