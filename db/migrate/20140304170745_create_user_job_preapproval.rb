class CreateUserJobPreapproval < ActiveRecord::Migration
  def change
    create_table :user_job_preapprovals do |t|
      t.integer :user_id
      t.integer :job_id
    end
  end
end
