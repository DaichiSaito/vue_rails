class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  # protected

  def pagination(records)
    {
        pagination: {
            per_page: records.per_page,
            total_pages: records.total_pages,
            total_objects: records.total_entries
        }
    }
  end

  def authenticate
    render json: {errors: 'Unauthorized'}, status: 401 unless current_user
  end

  def current_user
    @current_user ||= Jwt::UserAuthenticator.(request.headers)
  end
end
