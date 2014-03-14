class CreateUserSkills < ActiveRecord::Migration
  def change
    create_table :user_skills do |t|
      t.integer :user_id
      t.string :skill
      t.integer :level
    end
  end
end
