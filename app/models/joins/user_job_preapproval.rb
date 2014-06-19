class UserJobPreapproval < ActiveRecord::Base
  
  belongs_to :job  
  belongs_to :preapproved_user, class_name: 'User', foreign_key: :preapproved_user_id
  belongs_to :preapproval_applicant, class_name: 'User', foreign_key: :preapproval_applicant_id
  
end