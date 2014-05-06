class ChatsController < ApplicationController
	include ActionController::Live

	def index
		@chats = current_user.chats
	end

	def create
		response.headers["Content-Type"] = "text/javascript"
		@chat = Chat.create(chat_params)
		# random_hash = SecureRandom.urlsafe_base64
		$redis.publish("chats.create", @chat.to_json)
	end

	def events
		response.headers['Content-Type'] = "text/event-stream"
		start = Time.zone.now
		redis = Redis.new
		redis.psubscribe("chats.*") do |on|
			on.pmessage do |pattern, event, data|
				response.stream.write("pattern: #{pattern}\n")
				response.stream.write("event: #{event}\n")
				response.stream.write("data: #{data}\n\n")
			end
		end
	rescue IOError
		logger.info "Stream closed"
	ensure
		redis.quit
		response.stream.close
	end

	private

		def chat_params
			params.require(:chat).permit(:content, :user_id, :room_id)
		end


end