class Job < ActiveRecord::Base
  
  def self.unique_categories
    uniques = []

    Job.all.each do |job|
      uniques << job.category if !uniques.include?(job.category)
    end
    
    uniques
  end
  
  def self.import(file)
    Job.delete_all
    
    CSV.foreach(file.path, headers: true) do |row|
      Job.create!(row.to_hash)
    end
  end
  
  def self.search(settings_hash)
    if settings_hash.empty?
      jobs = self.all
    else
      if settings_hash[:category] 
        jobs = where("category IN (?)", settings_hash[:category])
      else
        jobs = self.all
      end
      
      if !settings_hash[:experience].nil?
        jobs = jobs.where("experience_required IN (?)", settings_hash[:experience])
      end
    end
    
    jobs
  end
	  	  
  # def self.search(category = nil, experience = nil)
  #   if category.blank?
  #     all
  #   else
  #     jobs = where("category IN (?)", category)
  #     
  #     if !experience.nil?
  #       jobs = jobs.where("experience_required IN (?)", experience)
  #     end
  #   end
  #   
  #   jobs
  # end

end
