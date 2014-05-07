class AlterChatroomColumns < ActiveRecord::Migration
  def change
  	remove_column :chatrooms, :content
  	rename_column :chatrooms, :user_id, :admin_id
  end
end
