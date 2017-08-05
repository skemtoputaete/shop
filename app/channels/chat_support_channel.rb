class ChatSupportChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_support_#{params['chat_room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create(content: data['message'], user: current_user, chatroom_id: data['chat_room_id'])
  end
end
