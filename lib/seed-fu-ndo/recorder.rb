module SeedFuNdo

  class Recorder
    attr_reader :seeders
    
    def initialize
      @seeders = []
    end
    
    def record(seeder)
      seeders << seeder
    end
    
    def unseed
      seeders.reverse.each do |seeder|
        seeder.unseed
      end
    end
    
  end
  
end
