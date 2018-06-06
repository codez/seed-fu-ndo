require 'seed-fu'
require 'seed-fu-ndo/seeder'
require 'seed-fu-ndo/railtie' if defined?(Rails) && Rails.version >= '3'

module SeedFuNdo
  autoload :Recorder, 'seed-fu-ndo/recorder'

  mattr_reader :recorder

  # Unload seed data from files. Main entry point for third-party libraries.
  # [fixture_paths] The paths to look for seed files in.
  # [filter] A regexp. If given, only filenames matching this expression will be loaded.
  def self.unseed(fixture_paths = SeedFu.fixture_paths, filter = nil)
    capture(fixture_paths, filter).reverse.each(&:unseed)
  end

  # Returns all seed records from the given fixture_paths that currently
  # exist in the database. No changes to the database are performed.
  def self.existing_seeds(fixture_paths = SeedFu.fixture_paths, filter = nil)
    existing = Hash.new { |h, k| h[k] = [] }
    capture(fixture_paths, filter).each do |seeder|
      existing[seeder.model_class] += seeder.existing_records
    end
    existing
  end

  # Captures the seed fixtures without actually inserting anything.
  # Returns a list of seeder objects.
  def self.capture(fixture_paths = SeedFu.fixture_paths, filter = nil)
    @@recorder = Recorder.new
    SeedFu::Runner.new(fixture_paths, filter).run
    @@recorder.seeders
  ensure
    @@recorder = nil
  end
end
