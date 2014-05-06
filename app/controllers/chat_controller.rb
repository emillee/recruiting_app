class ChatController < WebsocketRails::BaseController
  include ActionView::Helpers::SanitizeHelper

  def initialize_session
    puts "Session Initialized\n"
  end
  
  def system_msg(ev, msg)
    broadcast_message ev, { 
      user_name: 'system', 
      received: Time.now.to_s(:short), 
      msg_body: msg
    }
  end
  
  def user_msg(ev, msg)
    broadcast_message ev, { 
      user_name:  connection_store[:user][:user_name], 
      received:   Time.now.to_s(:short), 
      msg_body:   ERB::Util.html_escape(msg) 
      }
  end
  
  def client_connected
    system_msg :new_message, "client #{client_id} connected"
  end
  
  def new_message
    user_msg :new_message, message[:msg_body].dup
  end
  
  def new_user
    connection_store[:user] = { user_name: sanitize(message[:user_name]) }
    broadcast_user_list
  end
  
  def change_username
    connection_store[:user][:user_name] = sanitize(message[:user_name])
    broadcast_user_list
  end
  
  def delete_user
    connection_store[:user] = nil
    system_msg "client #{client_id} disconnected"
    broadcast_user_list
  end
  
  def broadcast_user_list
    users = connection_store.collect_all(:user)
    broadcast_message :user_list, users
  end

	# THIS IS FOR REDIS PUBSUB
	# include ActionController::Live

	# def index
	# 	@chats = current_user.chats
	# end

	# def create
	# 	response.headers["Content-Type"] = "text/javascript"
	# 	@chat = Chat.create(chat_params)
	# 	# random_hash = SecureRandom.urlsafe_base64
	# 	$redis.publish("chats.create", @chat.to_json)
	# end

	# def events
	# 	response.headers['Content-Type'] = "text/event-stream"
	# 	start = Time.zone.now
	# 	redis = Redis.new
	# 	redis.psubscribe("chats.*") do |on|
	# 		on.pmessage do |pattern, event, data|
	# 			response.stream.write("pattern: #{pattern}\n")
	# 			response.stream.write("event: #{event}\n")
	# 			response.stream.write("data: #{data}\n\n")
	# 		end
	# 	end
	# rescue IOError
	# 	logger.info "Stream closed"
	# ensure
	# 	redis.quit
	# 	response.stream.close
	# end

	# private

	# 	def chat_params
	# 		params.require(:chat).permit(:content, :user_id, :room_id)
	# 	end


end