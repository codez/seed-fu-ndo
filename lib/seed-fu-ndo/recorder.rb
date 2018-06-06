module SeedFuNdo
  # Records seeder instances created by Seed Fu.
  class Recorder
    attr_reader :seeders

    def initialize
      @seeders = []
    end

    # Record a single seeder.
    def record(seeder)
      seeders << seeder
    end
  end
end
