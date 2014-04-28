class RenameUserSkills < ActiveRecord::Migration
  def change
  	rename_table :user_skills, :object_skills
  end
end
