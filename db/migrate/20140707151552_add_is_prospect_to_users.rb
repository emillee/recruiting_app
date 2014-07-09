class AddIsProspectToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :is_prospect, :boolean
  end
end
