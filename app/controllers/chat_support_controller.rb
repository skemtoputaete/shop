class ChatSupportController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin_role? then
      @chatrooms = Chatroom.all
    end
  end

  def write
    @user = User.find(current_user.id)
    @chatroom = @user.chatroom

    if @chatroom == nil then
      Chatroom.create(user: @user)
      @chatroom = @user.chatroom
    end

    redirect_to action: "show", id: @chatroom.id
  end

  def show
    @room_id = params[:id]
    @messages = Chatroom.find(@room_id).messages
  end

end
