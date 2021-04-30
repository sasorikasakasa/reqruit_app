class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    # 自分がいるチャットルームを取得
    # 自分がいるチャットルームからマッチング一覧ページからクリックしたユーザーがいるチャットルームを取得
    # 2でチャットルームが存在しなければチャットルームを作成
    # チャットルームに遷移

    current_user_chat_rooms = ChatRoomUser.where(user_id: current_user.id).map(&:chat_room_id)
    chat_room = ChatRoomUser.where(user_id: params[:user_id],chat_room_id: current_user_chat_rooms).map(&:chat_room_id).first
    if chat_room.blank?
      chat_room = ChatRoom.create
      ChatRoomUser.create(chat_room_id: chat_room.id , user_id: current_user.id)
      ChatRoomUser.create(chat_room_id: chat_room.id , user_id: params[:user_id])
    end
    redirect_to action: :show , id: chat_room
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
    @chat_room_user = @chat_room.chat_room_users.where.not(user_id: current_user.id).first.user
    @chat_messages = ChatMessage.where(chat_room_id: @chat_room.id).order(:id).last(100)
  end

  def show_additionally
    last_id = params[:oldest_message_id].to_i - 1
    @chat_messages = ChatMessage.includes(:user).order(:id).where(id: 1..last_id).last(50)
    @chat_room = ChatRoom.find(params[:id])
    @chat_room_user = @chat_room.chat_room_users.where.not(user_id: current_user.id).first.user
  end

end
