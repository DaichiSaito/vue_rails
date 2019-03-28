class Api::V1::ProfilesController < ApplicationController
  before_action :authenticate
  before_action :set_user
  def update
    if @user.update(user_params)
      render json: @user, adapter: :json
    else
      render json: @user.errors, adapter: :json
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :age_id)
  end
end
