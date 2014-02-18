class RenameKeySkillsToKeyPhrases < ActiveRecord::Migration
  def change
    rename_column :jobs, :key_skills, :key_phrases
  end
end
