var ready_chats = function() {   
  var room_id = document.URL.split('room_id=')[1].slice(0,22);
  var chatroom_selector = '#chat-' + room_id;

  if ($(chatroom_selector).length > 0 ) {

    (function() {
      var __bind = function(fn, me) { 
        return function() { 
          return fn.apply(me, arguments); 
        }; 
      };

      jQuery(function() {
        window.chatController = new Chat.Controller($(chatroom_selector).data('uri'), true);
      });

      window.Chat = {};

      Chat.Controller = (function() {

        Controller.prototype.template = function(message) {
          console.log('template');
          var html;
          html = "<div class=\"message\" >\n  <label class=\"label label-info\">\n [" + 
          message.received + "] " + message.user_name + "\n  </label>&nbsp;\n  " + 
          message.msg_body + "\n</div>";

          return $(html);
        };

        function Controller(url, useWebSockets) {
          this.sendMessage = __bind(this.sendMessage, this);
          this.newMessage = __bind(this.newMessage, this);
          this.bindEvents = __bind(this.bindEvents, this);
          this.dispatcher = new WebSocketRails(url, useWebSockets);
          this.bindEvents();

        };

        Controller.prototype.bindEvents = function() {
          console.log('bindEvents');
          this.dispatcher.bind('new_message', this.newMessage);
          this.channel = this.dispatcher.subscribe(room_id);
          this.dispatcher.trigger('make_channel_private', { channel_name: room_id });
          console.log("channel name: " + this.channel.name)
          
          this.channel.bind('new_message', this.newMessage);

          $('#send').on('click', this.sendMessage);
        };

        Controller.prototype.newMessage = function(message) {
          console.log('newMessage');
          console.log("channel name in NewMessage: " + this.channel.name)

          return this.appendMessage(message);
        };

        Controller.prototype.sendMessage = function(event) {
          console.log('sendMessage');
          var message;
          event.preventDefault();
          message = $('#message_message_body').val();

          this.dispatcher.trigger('create_new_message', {
            msg_body: message,
            user_id: $('#message_user_id').val(),
            chatroom_id: $('#message_chatroom_id').val()
          });

          $('#message_message_body').val('');
        };

        Controller.prototype.appendMessage = function(message) {
          console.log('appendMessage');
          var messageTemplate;
          messageTemplate = this.template(message);
          $(chatroom_selector).append(messageTemplate);
          return messageTemplate.slideDown(140);
        };

        return Controller;
      })();

    }).call(this);

  };
};

$(document).ready(ready_chats);
$(document).on('page:load', ready_chats);


