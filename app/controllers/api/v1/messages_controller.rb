class Api::V1::MessagesController < ApplicationController
  before_action :authenticate

  def create
    message = Message.create!(message_params)
    render json: message, adapter: :json
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :chatroom_id, :body)
  end
end
