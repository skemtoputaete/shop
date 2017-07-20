class ChatSupportController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin_role? || current_user.supervisor_role? then
      @chatrooms = Chatroom.all
    end
  end

  def write
    # Проверим, попал ли на данный метод посетитель с правами пользователя
    if current_user.user_role?
      # Найдем комнату "чата" для данного посетителя
      @user = User.find(current_user.id)
      @chatroom = @user.chatroom
      # Если ее не существует, то создадим
      if @chatroom == nil then
        Chatroom.create(user: @user)
        @chatroom = @user.chatroom
      end
      # Направим пользователя в эту чат-комнату
      redirect_to action: "show", id: @chatroom.id
    else
      redirect_to action: "index"
    end
  end

  def show
    @room_id = params[:id]
    @messages = Chatroom.find(@room_id).messages
  end

end
