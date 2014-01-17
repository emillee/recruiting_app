class Job < ActiveRecord::Base
  
  def self.unique_categories
    uniques= []

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
  
  def self.search(category = nil, experience = nil)
    if category.blank?
      all
    else
      jobs = where("category IN (?)", category)
      
      if !experience.nil?
        jobs = jobs.where("experience_required IN (?)", experience)
      end
    end
    
    jobs
  end
end
