$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tb-helpers/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tb-helpers"
  s.version     = TbHelpers::VERSION
  s.authors     = ["Michael Nowak"]
  s.email       = ["thexsystem@gmail.com"]
  s.homepage    = "https://github.com/mmichaa/tb-helpers"
  s.summary     = "Twitter-Bootstrap-Helpers -- Rails 3 View-Helpers for Twitter-Bootstrap"
  s.description = "Twitter-Bootstrap-Helpers -- Rails 3 View-Helpers for Twitter-Bootstrap"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.0"

  s.add_development_dependency "sqlite3"
end
