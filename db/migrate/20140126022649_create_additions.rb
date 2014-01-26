class CreateAdditions < ActiveRecord::Migration
  def change
    create_table :additions do |t|
      t.integer :skill_set_id
      t.integer :skill_id
      t.text :description
      t.integer :skill_level
      t.string :field_type

      t.timestamps
    end
  end
end
