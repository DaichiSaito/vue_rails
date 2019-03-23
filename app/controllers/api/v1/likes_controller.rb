class Api::V1::LikesController < ApplicationController
  before_action :authenticate
  def create
    @user = User.find(params[:to_id])
    current_user.like(@user)
    render json: UserSerializer.new(@user)
  end
end
