class AddPreapprovalApplicantToUserJobPreapproval < ActiveRecord::Migration
  def change
  	add_column :user_job_preapprovals, :preapproval_applicant_id, :integer
  	rename_column :user_job_preapprovals, :user_id, :preapproved_user_id
  end
end
