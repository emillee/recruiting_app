class CreateUserSavedJobsTable < ActiveRecord::Migration
  def change
    create_table :user_jobs do |t|
      t.integer :user_id
      t.integer :saved_job_id
      t.integer :applied_job_id
    end
  end
end
