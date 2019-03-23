class Api::V1::UsersController < ApplicationController
  before_action :authenticate, only: [:like_users]
  def index
    @users = User.all.includes(:passive_likes)
    # render json: { users: @users.to_json(include: [:passive_likes]) }, status: :ok
    # render json: @users.to_json(include: [:passive_likes]), status: :ok
    options = { include: [:passive_likes] }
    render json: UserSerializer.new(@users, options)
  end

  def like_users
    users = current_user.like_users#.paginate(page: params[:page])
    render json: UserSerializer.new(users)
  end

  def be_liked_users

  end

  def matching_users
    # current_user.matching_users
  end
end
