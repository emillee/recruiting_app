class RenameMessagesToChats < ActiveRecord::Migration
  def change
  	rename_table :messages, :chats
  end
end
