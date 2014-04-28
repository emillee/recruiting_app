class AddColumnsToSkills < ActiveRecord::Migration
  def change
  	add_column :skills, :required_phrases, :string, array: true, default: []
  	add_column :skills, :preferred_phrases, :string, array: true, default: []
  end
end
