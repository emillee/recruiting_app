module CsvMethods
  extend ActiveSupport::Concern
  
  module ClassMethods
    
    def import_from_csv(delete_prev = false, file)
      if delete_prev
        self.class.delete_all
      end

      CSV.foreach(file.path, headers: true) do |row|
        self.class.create!(row.to_hash)
      end
    end
    
    def to_csv
      CSV.generate do |csv|
        csv << column_names
        all.each do |product|
          csv << product.attributes.values_at(*column_names)
        end
      end
    end
    
  end
  
  
end