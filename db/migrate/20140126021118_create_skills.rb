class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.integer :parent_id
      t.integer :skills_category_id

      t.timestamps
    end
  end
end
