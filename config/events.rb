WebsocketRails::EventMap.describe do
	# NOTE: any methods stated here that don't exist will result in stack level too deep errors
	subscribe :make_chatroom_private, 	to: ChatController, with_method: :make_chatroom_private
	subscribe :subscribe_private,				to: ChatController, with_method: :authorize_channel

  # subscribe :client_connected,      to: ChatController, with_method: :client_connected
  # subscribe :client_disconnected,   to: ChatController, with_method: :delete_user
  # subscribe :subscribe_private,     to: ChatController, with_method: :subscribe_private
end













