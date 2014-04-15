class AddLocationFromToUsers < ActiveRecord::Migration
  def change
    add_column :users, :location_from, :string
  end
end
