class CreateTechStackAgain < ActiveRecord::Migration
  def change
    create_table :skills do |t|
    	t.string :skill_name
    	t.string :skill_dept
    	t.string :skill_sub_dept
    end
  end
end
