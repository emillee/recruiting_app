class AddReqSkillsToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :req_skills, :string, array: true, default: []
  end
end

