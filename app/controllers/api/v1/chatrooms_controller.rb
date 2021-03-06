class Api::V1::ChatroomsController < ApplicationController
  before_action :authenticate
  def index
    # @chatrooms = current_user.chatrooms.includes(:users)
    # # options = { include: [:chatroom_users, :'chatroom_users.users'] }
    # options = { include: [:users] }
    # render json: ChatroomSerializer.new(@chatrooms, options).serialized_json

    chatrooms = current_user.chatrooms.includes(:users)
    render json: chatrooms,  adapter: :json
  end

  # def show
  #   chatroom = current_user.chatrooms.find(params[:id])
  #   render json: chatroom,  adapter: :json
  # end
end
