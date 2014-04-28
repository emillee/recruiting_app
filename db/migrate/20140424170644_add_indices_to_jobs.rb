class AddIndicesToJobs < ActiveRecord::Migration
  def change
  	add_index :jobs, :company_id

  	add_index :object_skills, :user_id
  	add_index :object_skills, :company_id

  	add_index :users, :company_id

  	add_index :user_jobs, :user_id
  	add_index :user_jobs, [:user_id, :applied_job_id]
  	add_index :user_jobs, [:user_id, :saved_job_id]
  	add_index :user_jobs, [:user_id, :removed_job_id]
  end
end
