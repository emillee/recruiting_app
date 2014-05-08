class ChatroomsController < ApplicationController

	def index
	end

	def create
		random_string = (0...7).map { (65 + rand(26)).chr }.join.downcase

		@chatroom = Chatroom.new(
			room_id: random_string,
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