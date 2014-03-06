class UserJobPreapproval < ActiveRecord::Base
  
  belongs_to(
    :job,
    class_name: 'Job',
    foreign_key: :job_id,
    primary_key: :id
  )
  
  belongs_to(
    :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )
  
end