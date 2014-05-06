class CreateUserChats < ActiveRecord::Migration
  def change
    create_table :user_chats do |t|
    	t.integer :user_one
    	t.integer :user_two
    end
  end
end
