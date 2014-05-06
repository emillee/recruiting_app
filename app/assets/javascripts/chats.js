$(document).ready(function() {
	var source = new EventSource('/chats/events');
	var eventSource = "chats" + 
	source.addEventListener('chats.create', function(e) {
		chat = $.parseJSON(e.data);
		$('#chat').append($('<li>').text(chat.content))
	}, false);
})

