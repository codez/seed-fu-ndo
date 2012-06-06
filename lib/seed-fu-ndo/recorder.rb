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
    
    # Unseed the data of all the recorded seeders in reverse order.
    def unseed
      ActiveRecord::Base.transaction do 
        seeders.reverse.each do |seeder|
          seeder.unseed
        end
      end
    end
    
  end
  
end
