class Api::V1::Chatrooms::MessagesController < ApplicationController
  before_action :authenticate
  before_action :set_chatroom, only: [:index]

  def index
    messages = @chatroom.messages

    # TODO めっちゃ副作用がある
    chatroom_user = current_user.chatroom_users.find_by(chatroom_id: params[:chatroom_id])
    chatroom_user.update(last_read_at: Time.zone.now)

    render json: messages, adapter: :json
  end

  def create
    message = Message.create!(message_params)
    render json: message, adapter: :json
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end

  def message_params
    params.require(:message).permit(:user_id, :chatroom_id, :body)
  end
end
