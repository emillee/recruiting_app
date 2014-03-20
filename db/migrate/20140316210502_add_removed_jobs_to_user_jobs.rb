class AddRemovedJobsToUserJobs < ActiveRecord::Migration
  def change
    add_column :user_jobs, :removed_job_id, :integer
  end
end
