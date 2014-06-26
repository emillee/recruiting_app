class ChangeUserJobColumns < ActiveRecord::Migration
  def change
  	add_column :user_jobs, :viewed_job_id, :integer
  	rename_column :user_jobs, :saved_job_id, :bookmarked_job_id
  	rename_column :user_jobs, :applied_job_id, :applied_via_wolfpack_job_id
  end
end

