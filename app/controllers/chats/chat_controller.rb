class ChatController < WebsocketRails::BaseController
  include ActionView::Helpers::SanitizeHelper

  def make_channel_private
    channel_name = message[:channel_name]
    WebsocketRails[channel_name].make_private
  end

  def subscribe_private
    channel = message[:channel_name]
    accept_channel current_user
  end

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
  
  def user_msg(ev, username, msg)
    send_message ev, { 
      user_name: username,
      # user_name:  connection_store[:user][:user_name], 
      received:   Time.now.to_s(:short), 
      msg_body:   ERB::Util.html_escape(msg) 
      }
  end

  def new_user
    connection_store[:user] = { user_name: sanitize(message[:user_name]) }
    broadcast_user_list
  end  
  
  def client_connected
    system_msg :new_message, "client #{client_id} connected haha"
  end
  
  def new_message
    # user_msg :new_message, message[:msg_body].dup
    p "--- CHANNEL? SELF.NAME #{self.name}"
    user_msg :new_message, current_user.fname, message[:msg_body].dup
  end

  def create_new_message
    p 'IN HERE CHAT CONTROLLER'
    p "--- CHANNEL? SELF.NAME"
    p "#{self}"

    this_message = Message.create(
      message_body: message[:msg_body],
      user_id: message[:user_id]
    )

    ChatroomMessage.create(
      message_id: this_message.id,
      chatroom_id: message[:chatroom_id]
    )

    user_msg :new_message, current_user.fname, message[:msg_body].dup
  end
  
  def broadcast_user_list
    users = connection_store.collect_all(:user)
    broadcast_message :user_list, users
  end

end





  
  # def change_username
  #   connection_store[:user][:user_name] = sanitize(message[:user_name])
  #   broadcast_user_list
  # end
  
  # def delete_user
  #   connection_store[:user] = nil
  #   system_msg "client #{client_id} disconnected"
  #   broadcast_user_list
  # end