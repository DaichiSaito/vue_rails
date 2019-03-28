class Api::V1::AgesController < ApplicationController
  before_action :authenticate

  def index
    render json: Age.all, adapter: :json
  end

end
