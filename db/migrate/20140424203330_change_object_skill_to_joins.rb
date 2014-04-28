class ChangeObjectSkillToJoins < ActiveRecord::Migration
  def change
  	remove_column :object_skills, :skill
  	add_column :object_skills, :skill_id, :integer
  end
end
