class Job < ActiveRecord::Base
  
  def self.unique_departments
    unique_dept_arr = []

    Job.all.each do |job|
      unique_dept_arr << job.department if !unique_dept_arr.include?(job.department)
    end
    
    unique_dept_arr
  end
  
end
