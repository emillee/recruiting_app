class AddLogoToSkills < ActiveRecord::Migration
  def change
  	add_attachment :skills, :logo
  end
end
