$:.push File.expand_path("../lib", __FILE__)

require 'seed-fu-ndo/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "seed-fu-ndo"
  s.version     = SeedFuNdo::VERSION
  s.authors     = ["Pascal Zumkehr"]
  s.email       = ["spam@codez.ch"]
  #s.homepage    = "TODO"
  s.summary     = "Seed-Fu-ndo adds undo functionality to Seed-Fu"
  s.description = ""

  s.files = Dir["{lib}/**/*"] + ["Rakefile"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "seed-fu", '>= 2.2.0'
  
end
