jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  if $('#messages').length > 0

    App.chat_support = App.cable.subscriptions.create {
      channel: "ChatSupportChannel",
      chat_room_id: messages.data('chat-room-id')
      },

      connected: ->
      # Called when the subscription is ready for use on the server

      disconnected: ->
      # Called when the subscription has been terminated by the server

      received: (data) ->
      # Called when there's incoming data on the websocket for this channel
        $('#messages').append data['message']

      speak: (message, chat_room_id) ->
        @perform 'speak', message: message, chat_room_id: chat_room_id

      $(document).on 'keypress', '[data-behavior~=chat_support_speaker]', (event) ->
        if event.keyCode is 13
          App.chat_support.speak event.target.value, messages.data('chat-room-id')
          event.target.value = ''
          event.preventDefault()
