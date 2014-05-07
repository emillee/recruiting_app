var ready_chats = function() {   
  var room_id = document.URL.split('room_id=')[1].slice(0,22);
  var chatroom_selector = '#chat-' + room_id;

  if ($(chatroom_selector).length > 0 ) {

    // $('#send').on('click', function(e) {
    //   e.preventDefault();
    //   var message = $('#message_message_body').val();
    //   var $user_id = $('#message_user_id').val();
    //   var $chatroom_id = $('#message_chatroom_id').val();

    //   var dataObject = {};
    //   dataObject['message'] = {};
    //   dataObject['message']['user_id'] = $user_id;
    //   dataObject['message']['chatroom_id'] = $chatroom_id;
    //   dataObject['message']['message_body'] = message;

    //   $.ajax({
    //     type: 'POST',
    //     url: '/messages',
    //     data: dataObject
    //   });
    // });

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

      // Chat.User = (function() {
      //   function User(user_name) {
      //     this.user_name = user_name;
      //     this.serialize = __bind(this.serialize, this);
      //   }

      //   User.prototype.serialize = function() {
      //     return {
      //       user_name: this.user_name
      //     };
      //   };

      //   return User;
      // })();

      Chat.Controller = (function() {

        Controller.prototype.template = function(message) {
          console.log('template');
          var html;
          html = "<div class=\"message\" >\n  <label class=\"label label-info\">\n [" + 
          message.received + "] " + message.user_name + "\n  </label>&nbsp;\n  " + 
          message.msg_body + "\n</div>";

          return $(html);
        };

        // Controller.prototype.userListTemplate = function(userList) {
        //   var user, userHtml, _i, _len;
        //   userHtml = "";
        //   for (_i = 0, _len = userList.length; _i < _len; _i++) {
        //     user = userList[_i];
        //     userHtml = userHtml + ("<li>" + user.user_name + "</li>");
        //   }

        //   return $(userHtml);
        // };

        function Controller(url, useWebSockets) {
          // this.createGuestUser = __bind(this.createGuestUser, this);
          // this.shiftMessageQueue = __bind(this.shiftMessageQueue, this);
          // this.updateUserInfo = __bind(this.updateUserInfo, this);
          // this.updateUserList = __bind(this.updateUserList, this);
          this.sendMessage = __bind(this.sendMessage, this);
          this.newMessage = __bind(this.newMessage, this);
          this.bindEvents = __bind(this.bindEvents, this);
          // this.messageQueue = [];
          this.dispatcher = new WebSocketRails(url, useWebSockets);
          // this.dispatcher.on_open = this.createGuestUser;
          this.bindEvents();
        };

        Controller.prototype.bindEvents = function() {
          console.log('bindEvents');
          this.dispatcher.bind('new_message', this.newMessage);
        //   this.dispatcher.bind('user_list', this.updateUserList);
        //   $('input#user_name').on('keyup', this.updateUserInfo);
          $('#send').on('click', this.sendMessage);
          // return $('#message_message_body').keypress(function(e) {
          //   if (e.keyCode === 13) {
          //     return $('#send').click();
          //   }
          // });
        };

        Controller.prototype.newMessage = function(message) {
          console.log('newMessage');
        //   this.messageQueue.push(message);
        //   if (this.messageQueue.length > 15) {
        //     this.shiftMessageQueue();
        //   }

          return this.appendMessage(message);
        };

        Controller.prototype.sendMessage = function(event) {
          console.log('sendMessage');
          var message;
          event.preventDefault();
          message = $('#message_message_body').val();

        //   this.dispatcher.trigger('new_message', {
        // //     user_name: this.user.user_name,
        //     msg_body: message,
        //     user_id: $('#message_user_id').val(),
        //     chatroom_id: $('#message_chatroom_id').val()            
        //   });


          this.dispatcher.trigger('create_new_message', {
            msg_body: message,
            user_id: $('#message_user_id').val(),
            chatroom_id: $('#message_chatroom_id').val()
          });

          $('#message_message_body').val('');
        };

        // Controller.prototype.updateUserList = function(userList) {
        //   console.log('updateUserList');
        //   return $('#user-list').html(this.userListTemplate(userList));
        // };

        // Controller.prototype.updateUserInfo = function(event) {
        //   console.log('updateUserInfo');
        //   this.user.user_name = $('input#user_name').val();
        //   $('#username').html(this.user.user_name);
        //   return this.dispatcher.trigger('change_username', this.user.serialize());
        // };

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


