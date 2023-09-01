class MembersController < ApplicationController
    before_action :set_member, only: [:show, :edit, :update, :destroy]

    def show
        user = get_user_from_token
        render json: {
            message: "Member retrieved successfully",
            user: user
        }
    end

    private

    def get_user_from_token
        jwt_payload = JWT.decode(request.headers["Authorization"].split(" ")[1], 
        Rails.application.credentials.devise[:jwt_secret_key]).first
        user_id = User.find(jwt_payload["sub"])
        user = User.find(user_id.to_s)
    end
end