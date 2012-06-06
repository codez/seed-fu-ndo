require 'seed-fu'
require 'seed-fu-ndo/seeder'
require 'seed-fu-ndo/railtie' if defined?(Rails) && Rails.version >= "3"

module SeedFuNdo
  autoload :Recorder, 'seed-fu-ndo/recorder'
  
  mattr_reader :recorder
  
  # Unload seed data from files. Main entry point for third-party libraries.
  # [fixture_paths] The paths to look for seed files in.
  # [filter] A regexp. If given, only filenames matching this expression will be loaded.
  def self.unseed(fixture_paths = SeedFu.fixture_paths, filter = nil)
    @@recorder = Recorder.new
    SeedFu::Runner.new(fixture_paths, filter).run
    @@recorder.unseed
  ensure
    @@recorder = nil
  end
  
end