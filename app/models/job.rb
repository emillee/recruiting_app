class Job < ActiveRecord::Base
  
  def self.unique_categories
    unique_category_arr = []

    Job.all.each do |job|
      unique_category_arr << job.category if !unique_category_arr.include?(job.category)
    end
    
    unique_category_arr
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
      @jobs = where("category IN (?)", category)
      if !experience.nil?
         @jobs = @jobs.where("experience_required IN (?)", experience)
      end
    end
    
    @jobs
  end
end
