class AddFullTextToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :full_text, :text
  end
end
