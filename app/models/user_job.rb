class UserJob < ActiveRecord::Base
  
  belongs_to(
    :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )
  
  belongs_to(
    :job_applied_to,
    class_name: 'Job',
    foreign_key: :applied_job_id,
    primary_key: :id
  )
  
  belongs_to(
    :job_saved,
    class_name: 'Job',
    foreign_key: :saved_job_id,
    primary_key: :id
  )
  
  belongs_to(
    :removed_job,
    class_name: 'Job',
    foreign_key: :removed_job_id,
    primary_key: :id
  )
  
end