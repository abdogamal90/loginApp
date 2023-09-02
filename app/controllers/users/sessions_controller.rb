class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private
    
  def respond_with(resource, opts = {})
  
    if current_user
        handle_successful_sign_in(resource)
    else
        handle_failed_sign_in(resource)
    end
  end

    def handle_successful_sign_in(resource)
        token = JWT.encode({ sub: resource.id }, Rails.application.credentials.devise[:jwt_secret_key], 'HS256')

        render json: {
            message: "Signed in successfully.",
            user: resource,
            token: token
        }
    end

    def handle_failed_sign_in(resource)
        render json: {
            message: "Invalid login credentials. Please try again."
        }, status: :unauthorized
    end


  def respond_to_on_destroy
    log_out_success && return if !current_user
  end

  def log_out_success
    render json: { message: 'Logged out successfully.' }
  end

  def log_out_failure
    render json: { message: 'Something went wrong.' }
  end
end
