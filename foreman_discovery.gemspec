$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "foreman_discovery/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "foreman_discovery"
  s.version = ForemanDiscovery::VERSION
  s.authors = IO.readlines("AUTHORS", encoding: "utf-8").map(&:strip)
  s.email = "gsutclif@redhat.com"
  s.description = "MaaS Discovery Plugin engine for Foreman"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = Dir["{app,extra,config,db,lib,webpack}/**/*"] + Dir["locale/**/*.{po,pot,mo}"] +
    ["LICENSE", "README.md", "package.json"]
  s.test_files = Dir["test/**/*"]
  s.homepage = 'https://github.com/theforeman/foreman_discovery'
  s.licenses = ["GPL-3.0"]
  s.summary = %q{MaaS Discovery Plugin for Foreman}
end
