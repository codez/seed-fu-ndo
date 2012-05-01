module SeedFu
  
  class Seeder
    
    
    def seed_with_undo
      if r = SeedFuNdo.recorder
        r.record self
        
        # return existing records in case they are processed by the caller
        @data.map { |record_data| find_record(data) }
      else
        seed_without_undo
      end
    end
    alias_method_chain :seed, :undo
    
    def unseed
      @model_class.transaction do
        @data.reverse.map { |record_data| unseed_record(record_data.symbolize_keys) }
      end
    end
    
    private
    
    def unseed_record(data)
        record = find_record(data)
        return if record.nil?

        puts " - Remove #{@model_class} #{data.inspect}" unless @options[:quiet]

        record.destroy || raise(ActiveRecord::ActiveRecordError(record.errors.full_messages.join(", ").presence))
    end
    
    def find_record(data)
      @model_class.where(constraint_conditions(data)).first
    end
  end
  
end