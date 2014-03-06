class DropUserJobPreapproves < ActiveRecord::Migration
  def change
    drop_table :user_job_preapproves
  end
end
