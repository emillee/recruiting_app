class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :biography
  	remove_column :users, :intro
  	remove_column :users, :interested_in_meeting
  end
end
