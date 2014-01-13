class Search < ActiveRecord::Base
  
  def jobs
    @jobs ||= find_jobs
  end
  
  private
  
  def find_jobs
    jobs = Job.where("category = ?", category) if category.present?
  end
  
end
