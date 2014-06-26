class UserJob < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :viewed_job, class_name: 'Job', foreign_key: :viewed_job_id
  belongs_to :bookmarked_job, class_name: 'Job', foreign_key: :bookmarked_job_id
  belongs_to :job_applied_via_wolfpack, class_name: 'Job', foreign_key: :applied_via_wolfpack_job_id
  belongs_to :removed_job, class_name: 'Job', foreign_key: :removed_job_id
  
end
