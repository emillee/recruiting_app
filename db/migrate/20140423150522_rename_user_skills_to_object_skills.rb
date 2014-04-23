class RenameUserSkillsToObjectSkills < ActiveRecord::Migration
  def change
  	def self.up
  		rename_table :user_skills, :object_skills
  	end

  	def self.down
  		rename_table :object_skills, :user_skills
  	end
  end
end
