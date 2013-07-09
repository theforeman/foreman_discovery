$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "foreman_discovery/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = %q{foreman_discovery}
  s.version     = ForemanDiscovery::VERSION
  s.authors = ["Greg Sutcliffe"]
  s.email = %q{gsutclif@redhat.com}
  s.description = %q{MaaS Discovery Plugin engine for Foreman }
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = Dir["{app,extra,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]
  s.homepage = %q{http://github.com/GregSutcliffe/foreman_discovery}
  s.licenses = ["GPL-3"]
  s.summary = %q{MaaS Discovery Plugin for Foreman}

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "open4"
  s.add_dependency "ftools"
  s.add_dependency "deface"


end
