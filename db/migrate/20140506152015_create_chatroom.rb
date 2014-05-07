class CreateChatroom < ActiveRecord::Migration
  def change
    rename_table :chats, :chatrooms
  end
end
