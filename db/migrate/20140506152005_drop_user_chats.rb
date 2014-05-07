class DropUserChats < ActiveRecord::Migration
  def change
  	drop_table :user_chats
  end
end
