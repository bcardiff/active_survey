$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_survey/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_survey"
  s.version     = ActiveSurvey::VERSION
  s.authors     = ["Brian J. Cardiff"]
  s.email       = ["bcardiff@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "Define surveys or questionnaires using a DSL over activerecord models."
  s.description = "Define surveys or questionnaires using a DSL over activerecord models."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"

  s.add_development_dependency "sqlite3"
end
