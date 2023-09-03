class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      register_success
    else
      register_failed(resource)
    end
  end

  def register_success
    
    # on success send the token along with the user object
    render json: {
        message: 'Signed up successfully.',
        user: resource,
        confirm_success: 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
    }

  end

  def register_failed(resource)
    if resource.errors[:email].include?('has already been taken')
      render json: { message: 'Email address is already in use.' }, status: :unprocessable_entity
    else
      render json: { message: 'Something went wrong.' }, status: :unprocessable_entity
    end
  end
end
