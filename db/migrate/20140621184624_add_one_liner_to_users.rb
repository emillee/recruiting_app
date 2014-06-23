class AddOneLinerToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :one_liner, :string
  end
end
