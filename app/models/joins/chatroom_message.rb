class ChatroomMessage < ActiveRecord::Base

	belongs_to :chatroom
	belongs_to :message

end