class ChatController < WebsocketRails::BaseController

  def make_chatroom_private
    p '-------MESSAGE IN MAKECHATROOM_PRIVATE'

    if message[:room_id]
      p '-------MESSAGE IN MAKECHATROOM_PRIVATE if block'
      WebsocketRails[message[:room_id]].make_private
      trigger_success 'successfully made chatroom private'
    else
      p '-------MESSAGE IN MAKECHATROOM_PRIVATE else blocks'
      trigger_failure 'nope - didnt make chatroom private'
    end
  end

  def authorize_channel
    p '-------MESSAGE IN authorize_channel'
    placeholder_for_test = true
    channel = WebsocketRails[message[:channel]]
    p '----'
    p "#{WebsocketRails[message[:channel]]}"
    if placeholder_for_test
      accept_channel
    else
      deny_channel({message: 'authorization failed'})
    end
  end

  def client_connected
    p 'inside client connected'
    p "#{request.url}"
  end

end




