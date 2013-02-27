# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'
require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "foreman_discovery"
  gem.homepage = "http://github.com/GregSutcliffe/foreman_discovery"
  gem.license = "GPL-3"
  gem.summary = %Q{MaaS Discovery Plugin for Foreman }
  gem.description = %Q{MaaS Discovery Plugin engine for Foreman }
  gem.email = "gsutclif@redhat.com"
  gem.authors = ["Greg Sutcliffe"]
  # dependencies defined in Gemfile
end

task :default => :test
