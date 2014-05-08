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
				
				room_to_publish = chatroom.room_id
				# room_to_publish = 'awesome'
				user_fname = @message.user.fname || 'user-name-placeholder'
				message_obj = @message.attributes.merge({user_fname: user_fname})

				WebsocketRails[room_to_publish].trigger(:publish_chatroom_message, message_obj)
				p 'in message#create'
			end
		
			# causes #SHOW to be served again, which isn't what we want, now causes an internal server errors
			# redirect_to :back
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