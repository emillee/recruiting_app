class MessagesController < ApplicationController

	def create
		chatroom_id = params[:message][:chatroom_id]
		@message = Message.new(message_params)

		if @message.save

			if chatroom_id
				@chatroom_message = ChatroomMessage.create(
					chatroom_id: chatroom_id,
					message_id: @message.id
				)
				chatroom = Chatroom.find(chatroom_id.to_i)
				
				p "ROOMID"
				p "#{chatroom.room_id}"
				some_object = {}
				room_to_publish = chatroom.room_id
				# room_to_publish = 'awesome'

				WebsocketRails[room_to_publish].trigger(:publish_chatroom_message, some_object)
				p 'in message#create'
			end
	
			redirect_to :back
		end
	end

	def destroy
		Message.find(params[:id]).destroy
	end

	private

		def message_params
			params.require(:message).permit(:message_body, :user_id)
		end

end