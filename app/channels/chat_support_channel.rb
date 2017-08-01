class ChatSupportChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_support_#{params['chat_room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # File.open('/home/maxim/projects/results.txt', 'w'){ |f| f.puts("Hello world") }
    # msg = data['message'].force_encoding("utf-8")
    Message.create(content: msg, user: current_user, chatroom_id: data['chat_room_id'])
  end
end
