class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fname, :string
    add_column :users, :lname, :string
    add_column :users, :title, :string
    add_column :users, :location, :string
    add_column :users, :company_id, :integer
  end
end
