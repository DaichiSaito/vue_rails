module Jwt::UserAuthenticator
  extend self

  def call(request_headers)
    @request_headers = request_headers

    begin
      p Jwt::TokenDecryptor.(token)
      payload, header = Jwt::TokenDecryptor.(token)
      p payload
      p header
      return User.find(payload['user_id'])
    rescue => e
      # log error here
      return nil
    end
  end

  def token
    @request_headers['Authorization'].split(' ').last
  end
end