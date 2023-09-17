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
      @token = JWT.encode({ sub: resource.id, exp: 24.hours.from_now.to_i }, Rails.application.credentials.devise[:jwt_secret_key])
        render json: {
            message: I18n.t('devise.sessions.signed_in'),
            user: resource,
            token: @token

        }
    end




    def handle_failed_sign_in(resource)
        
        if resource.errors[:email].include?('You have to confirm your email address before continuing.')
            render json: { message: I18n.t('devise.failure.unconfirmed')}, status: :unauthorized
        elsif resource.errors[:password].include?('Invalid password.')
            render json: { message: I18n.t('devise.passwords.wrong_password') }, status: :unauthorized
        elsif resource.errors[:email].include?('Invalid email address.')
            render json: { message: I18n.t('devise.failure.wrong_email') }, status: :unauthorized
        elsif !resource.confirmed?
            render json: { message: I18n.t('devise.failure.unconfirmed')}, status: :unauthorized
        else
            render json: { message: I18n.t('devise.failure.general_error'), errors: resource.errors }, status: :unprocessable_entity
        end
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
