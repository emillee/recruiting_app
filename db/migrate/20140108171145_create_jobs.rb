class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title_specific
      t.string :department
      t.string :experience_required
      t.string :company
      t.text :description
      t.string :link
  
      t.timestamps
    end
  end
end
