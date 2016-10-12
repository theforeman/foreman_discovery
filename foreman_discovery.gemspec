$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "foreman_discovery/version"

GEM_NAME = "foreman_discovery"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = GEM_NAME
  s.version = ForemanDiscovery::VERSION
  s.authors = IO.readlines("AUTHORS").map(&:strip)
  s.email = "gsutclif@redhat.com"
  s.description = "MaaS Discovery Plugin engine for Foreman"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = Dir["{app,extra,config,db,lib}/**/*"] + Dir["locale/**/*.{po,pot,mo}"] + ["LICENSE", "README.md"]
  s.test_files = Dir["test/**/*"]
  s.homepage = %q{http://github.com/theforeman/foreman_discovery}
  s.licenses = ["GPL-3.0"]
  s.summary = %q{MaaS Discovery Plugin for Foreman}
end
