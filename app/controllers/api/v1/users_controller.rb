class Api::V1::UsersController < ApplicationController
  before_action :authenticate, only: [:like_users]
  # def index
  #   @users = User.all.includes(:passive_likes)
  #   options = { include: [:passive_likes] }
  #   render json: UserSerializer.new(@users, options)
  # end
  def index
    users = User.paginate(page: params[:page], per_page: 10)
    render json: users, meta: pagination(users), adapter: :json
  end

  def like_users
    users = current_user.like_users
    render json: users, adapter: :json
    # render json: UserSerializer.new(users)
  end

  def be_liked_users

  end

  def matching_users
    # current_user.matching_users
  end
end
