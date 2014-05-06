source = new EventSource('/chats/events')
source.addEventListener 'chats.create', (e) ->
  chat = $.parseJSON(e.data)
  $('#chat').append($('<li>').text("#{chat.content}"))