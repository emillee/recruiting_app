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

		unless (@chatroom.admin == current_user || @chatroom.users.include?(current_user)) 
			ChatroomUser.create(chatroom_id: @chatroom.id, user_id: current_user.id)
		end

		room_to_publish = @chatroom.room_id
		user_fname = current_user.fname || 'user-name-placeholder'
		message_obj = { user_fname: user_fname }
		WebsocketRails[room_to_publish].trigger(:client_connected, message_obj)
	end

	private

		def chat_params
			params.require(:chat).permit(:content, :user_id, :room_id)
		end

end