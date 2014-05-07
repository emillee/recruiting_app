class ChatroomUsers < ActiveRecord::Migration
  def change
  	create_table :chatroom_users do |t|
  		t.integer :chatroom_id
  		t.integer :user_id

  		t.timestamps
  	end

  	add_index :chatroom_users, :chatroom_id
  	add_index :chatroom_users, :user_id
  end
end
