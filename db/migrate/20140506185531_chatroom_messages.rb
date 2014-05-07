class ChatroomMessages < ActiveRecord::Migration
  def change
  	create_table :chatroom_messages do |t|
  		t.integer :chatroom_id
  		t.integer :message_id
  	end

  	add_index :chatroom_messages, :chatroom_id  	
  end
end
