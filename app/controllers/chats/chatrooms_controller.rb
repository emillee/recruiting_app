class ChatroomsController < ApplicationController

	def index
	end

	def create
		@chatroom = Chatroom.new(
			room_id: SecureRandom.urlsafe_base64,
			admin_id: current_user.id
		)
		if @chatroom.save
			
			redirect_to chatroom_url(@chatroom, room_id: @chatroom.room_id)
		end
	end

	def show
		@message = Message.new
		@chatroom = Chatroom.find_by_room_id(params[:room_id])
	end

	private

		def chat_params
			params.require(:chat).permit(:content, :user_id, :room_id)
		end

end