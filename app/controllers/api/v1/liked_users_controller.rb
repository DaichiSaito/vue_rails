class Api::V1::LikedUsersController < ApplicationController
  before_action :authenticate
  def index
    users = current_user.be_liked_users.not_read_like.paginate(page: params[:page], per_page: 10)
    render json: users, meta: pagination(users), adapter: :json
  end
end
