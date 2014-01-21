class AddJobSettingsHashToUsers < ActiveRecord::Migration
  def change
    add_column :users, :job_settings, :text
  end
end
