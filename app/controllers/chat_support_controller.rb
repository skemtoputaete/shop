class ChatSupportController < ApplicationController

  def index

  end

  def write
    
  end

  def show
    @room_id = params[:id]
    @messages = Chatroom.find(@room_id).messages
  end

end
