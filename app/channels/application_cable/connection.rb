module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private
    def find_verified_user
      # or however you want to verify the user on your system
      # access_token = request.params[:'access-token']
      # client_id = request.params[:client]
      # verified_user = User.find_by(email: client_id)
      # if verified_user && verified_user.valid_token?(access_token, client_id)
      #   verified_user
      # else
      #   reject_unauthorized_connection
      # end
      p request.params[:'accesstoken']
      payload, header = Jwt::TokenDecryptor.(request.params[:'accesstoken'])
      p payload
      p 'あああああ'
      current_user = User.find_by(id: payload['user_id'])
      if current_user
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
