class Api::V1::LoginsController < ApplicationController

  def login_or_create
    user = Authentication.find_by(uid: params[:uid], provider: params[:provider])&.user
    if user
      token = Jwt::TokenProvider.(user_id: user.id)
      render json: { user: user, token: token }
    else
      ActiveRecord::Base.transaction do
        user = User.create(email: params[:email], name: params[:name])
        user.authentications.create(uid: params[:uid], provider: params[:provider])
      end
      render json: user, status: :created
    end
  end
end
