class CreateSkillsCategories < ActiveRecord::Migration
  def change
    create_table :skills_categories do |t|
      t.integer :parent_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
