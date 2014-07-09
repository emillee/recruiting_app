class AddIntroParagraphToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :intro_paragraph, :text
  end
end
