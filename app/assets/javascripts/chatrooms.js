var ready_chatroom = function() {    
  if ($('.chatrooms').length > 0 ) {
    console.log('chatroomjs')

  	// CREATE A DISPATCHER OBJECT
  	var dispatcher = new WebSocketRails($('#chat').data('uri'));
  	var room_id = document.URL.split('room_id=')[1].slice(0,16);

    window.onbeforeunload = function() {
      return "Please confirm that you want to exit this chatroom"

      dispatcher.trigger('client_disconnected')
    };

  	dispatcher.on_open = function(data) {
  		console.log('connection opened with connection:' + data);
  		
  		var message = { room_id: room_id };
  		dispatcher.trigger('make_chatroom_private', message, success, failure);
  	};

  	// callback for dispatcher.trigger
  	var success = function(response) {
  		console.log('success with response:' + response);
  	};

  	var failure = function(response) {
  		console.log('failure with response:' + response);
  	};  	

  	// SUBSCRIBE TO PRIVATE CHANNEL
		var private_channel = dispatcher.subscribe_private(room_id);	

  	private_channel.on_success = function(current_user) {
  		console.log('success private channel callback');
  	};

  	private_channel.on_failure = function(reason) {
  		console.log('failure private channel callback');
  	};

		private_channel.bind('publish_chatroom_message', function(data) {
			window.pubchandata = data;
			$('#chat > ul').append('<li>' + data.user_fname + ' : ' + data.message_body + '</li>');
			$('#message_message_body').val('');
		});

		private_channel.bind('client_connected', function(data) {
			$('#chat > ul').append('<li>Wolfpack : ' + data.user_fname  + ' has joined the room</li>');
			$('#user-list-ul').append('<li>' + data.user_fname + '</li>');
		});

    private_channel.bind('client_disconnected', function(data) {
      $('#chat > ul').append('<li class="' + data.user_fname +
           '">Wolfpack : ' + data.user_fname  + ' has left the room</li>');
    });    

  };
};

$(document).ready(ready_chatroom);
$(document).on('page:load', ready_chatroom);

