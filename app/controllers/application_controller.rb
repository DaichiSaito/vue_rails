class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  def authenticate
    render json: {errors: 'Unauthorized'}, status: 401 unless current_user
  end

  def current_user
    @current_user ||= Jwt::UserAuthenticator.(request.headers)
  end
end
