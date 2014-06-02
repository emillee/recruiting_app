class AddTheBigIdeaToCompanies < ActiveRecord::Migration
  def change
  	add_column :companies, :the_big_idea, :text
  end
end
