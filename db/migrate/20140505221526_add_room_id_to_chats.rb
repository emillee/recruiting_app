class AddRoomIdToChats < ActiveRecord::Migration
  def change
  	add_column :chats, :room_id, :string
  end
end
