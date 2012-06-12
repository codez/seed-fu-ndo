module SeedFu
  
  # Enhanced class from Seed Fu to allow for recording and destroying seed data.
  class Seeder
    
    attr_reader :model_class
    
    # Record instead of inserting the data if in recording mode. 
    def seed_with_undo
      if r = SeedFuNdo.recorder
        r.record self
        
        # return existing records in case they are processed by the caller
        @data.map { |record_data| find_record(record_data) }
      else
        seed_without_undo
      end
    end
    alias_method_chain :seed, :undo
    
    # Destroy the seed data.
    def unseed
      @model_class.transaction do
        existing_records.reverse.each { |record| unseed_record(record) }
      end
    end
    
    # List of the seeded records that exist in the database.
    def existing_records
      @data.map { |record_data| find_record(record_data.symbolize_keys) }.compact
    end
    
    private
    
    def unseed_record(record)
        puts " - Remove #{record.inspect}" unless @options[:quiet]

        record.destroy || raise(ActiveRecord::ActiveRecordError, record.errors.full_messages.join(", ").presence)
    end
    
    def find_record(data)
      @model_class.where(constraint_conditions(data)).first
    end
  end
  
end