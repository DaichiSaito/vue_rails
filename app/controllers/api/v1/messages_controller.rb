class Api::V1::MessagesController < ApplicationController
  before_action :authenticate
  before_action :set_chatroom, only: [:index]

  def index
    messages = @chatroom.messages
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
