class RemoveColumnsFromJobs < ActiveRecord::Migration
  def change
    remove_column :jobs, :key_phrase_one
    remove_column :jobs, :key_phrase_two
    remove_column :jobs, :key_phrase_three
    remove_column :jobs, :key_phrase_four
  end
end
