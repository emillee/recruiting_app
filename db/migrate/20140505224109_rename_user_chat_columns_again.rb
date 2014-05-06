class RenameUserChatColumnsAgain < ActiveRecord::Migration
  def change
  	rename_column :user_chats, :user_one, :user_one_id
  	rename_column :user_chats, :user_two, :user_two_id  	
  end
end
