class RenameColumnsInJobs < ActiveRecord::Migration
  def change
    rename_column :jobs, :key_skill_one, :key_phrase_one
    rename_column :jobs, :key_skill_two, :key_phrase_two
    add_column :jobs, :key_phrase_three, :string
    add_column :jobs, :key_phrase_four, :string
  end
end
