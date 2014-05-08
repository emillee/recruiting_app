var ready_chatroom = function() {    
  if ($('#chat').length > 0 ) {
  	console.log('chatroom loaded');

  	// CREATE A DISPATCHER OBJECT
  	var dispatcher = new WebSocketRails($('#chat').data('uri'));
  	var room_id = document.URL.split('room_id=')[1].slice(0,16);

  	dispatcher.on_open = function(data) {
  		console.log('connection opened with connection:' + data);
  		
  		var message = { room_id: room_id }
  		dispatcher.trigger('make_chatroom_private', message, success, failure);
  	};

  	// callback for dispatcher.trigger
  	var success = function(response) {
  		console.log('success with response:' + response);
  	};

  	var failure = function(response) {
  		console.log('failure with response:' + response);
  	};  	

  	// SUBSCRIBE TO A PUBLIC CHANNEL
  	// var room_id = 'awesome';
  	console.log('room_id = ' +room_id)
  	var channel = dispatcher.subscribe(room_id);
  	channel.bind('publish_chatroom_message', function(data) {
  		console.log('in here')
  		console.log('bound to publish_chatroom_message event with data:' + data);
  	});

  	// SUBSCRIBE TO PRIVATE CHANNEL
		// var private_channel = dispatcher.subscribe_private(room_id);	
		// var private_channel = dispatcher.subscribe_private('placeholder');	

  	// private_channel.on_success = function(current_user) {
  	// 	console.log('success private channel callback')
  	// 	// console.log(current_user.fname + 'has joined the channel');
  	// }

  	// private_channel.on_failure = function(reason) {
  	// 	console.log('failure private channel callback')
  	// 	// console.log( "Authorization failed because " + reason.message );
  	// } 

		// dispatcher.bind('publish_chatroom_message', function() {
		// 	console.log('received publish_chatroom_message')
		// })  	  	

	

  };
};

$(document).ready(ready_chatroom);
$(document).on('page:load', ready_chatroom);
