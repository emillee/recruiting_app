class AddIsDraftToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :is_draft, :boolean
  end
end
