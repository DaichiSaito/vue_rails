class Api::V1::LikesController < ApplicationController
  before_action :authenticate
  def create
    @user = User.find(params[:to_id])
    current_user.like(@user)

    if @user.liking?(current_user)
      current_user.read_like_by(@user)
      @user.read_like_by(current_user)
      Chatroom.start_chat([current_user, @user])
      # マッチングが成立したというメール
      # UserMailer.with(user: @user, from_user: current_user).matching.deliver_later if @user.mail_receive?
      render json: @user, meta: { matching: true }, adapter: :json
    else
      # いいねが届きましたというメール
      # UserMailer.with(user: @user, from_user: current_user).like.deliver_later if @user.mail_receive?
      render json: @user, adapter: :json
    end

    # render json: UserSerializer.new(@user)

  end
end
