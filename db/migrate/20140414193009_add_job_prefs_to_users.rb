class AddJobPrefsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :job_prefs, :text
  end
end
