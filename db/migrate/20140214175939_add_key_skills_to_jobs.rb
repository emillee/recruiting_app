class AddKeySkillsToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :key_skills, :string, array: true, default: []
  end
end
