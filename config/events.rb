WebsocketRails::EventMap.describe do
	private_channel :secret_channel_test

	# NOTE: any methods stated here that don't exist will result in stack level too deep errors
	subscribe :make_chatroom_private, 	to: ChatController, with_method: :make_chatroom_private

	namespace :websocket_rails do
		subscribe :subscribe_private,			to: ChatController, with_method: :authorize_channel
	end

  subscribe :client_connected,      to: ChatController, with_method: :client_connected
  # subscribe :client_disconnected,   to: ChatController, with_method: :delete_user
  # subscribe :subscribe_private,     to: ChatController, with_method: :subscribe_private
end













