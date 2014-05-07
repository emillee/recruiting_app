class Chatroom < ActiveRecord::Base

	belongs_to :admin, class_name: 'User', foreign_key: :admin_id
	
	has_many :chatroom_users
	has_many :chatroom_messages

	has_many :users, through: :chatroom_users, source: :user
	has_many :messages, through: :chatroom_messages, source: :message

end