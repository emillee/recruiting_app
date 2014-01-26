class CreateSkillSets < ActiveRecord::Migration
  def change
    create_table :skill_sets do |t|
      t.integer :job_id
      t.integer :user_id
      t.integer :category_id
      t.integer :company_id
      t.integer :set_type_id
      t.string :name
      t.text :desc

      t.timestamps
    end
  end
end
