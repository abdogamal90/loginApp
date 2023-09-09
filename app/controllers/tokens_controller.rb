class TokensController < ApplicationController
    def validate
      # get token from Authorization header
      token = request.headers['Authorization']
      puts token
      secret_key = Rails.application.credentials.devise[:jwt_secret_key]
      puts "Secret Key: #{secret_key}"
      begin
        decoded_token = JWT.decode(token,  Rails.application.credentials.devise[:jwt_secret_key], true, { algorithm: 'HS256' })
        if decoded_token
          render json: { valid: true, message: 'Token is valid.' }, status: :ok
        else
          render json: { valid: false, message: 'Token is invalid.' }, status: :unauthorized
        end
      rescue JWT::DecodeError => e
        puts e.message
        render json: { valid: false, message: 'Token is invalid.' }, status: :unauthorized
      end
    end
end