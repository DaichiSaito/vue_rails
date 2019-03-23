class Development::SessionsController < ApplicationController
  def login_as
    user = User.find(params[:user_id])
    token = Jwt::TokenProvider.(user_id: user.id)
    render json: { user: user, token: token }
  end
end
