class MessagesController < ApplicationController

	def create
		p 'IN MESSAGES CONTROLLER'
		@message = Message.new(message_params)

		if @message.save
			if params[:message][:chatroom_id]
				ChatroomMessage.create(
					chatroom_id: params[:message][:chatroom_id],
					message_id: @message.id
				)
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