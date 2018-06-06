$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'seed-fu-ndo/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'seed-fu-ndo'
  s.version     = SeedFuNdo::VERSION
  s.authors     = ['Pascal Zumkehr']
  s.email       = ['spam@codez.ch']
  s.homepage    = 'http://github.com/codez/seed-fu-ndo'
  s.summary     = 'Seed Fu-ndo adds undo functionality to Seed Fu'
  s.description = 'While Seed Fu solves the problem for inserting and maintaining seed data in a database, Seed Fu-ndo adds the possiblity to remove this data again.'

  s.files = Dir['{lib}/**/*'] + ['Rakefile']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'seed-fu', '>= 2.2.0'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'sqlite3'
end
