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
        user: resource,
        confirm_success: I18n.t('devise.registrations.signed_up_but_unconfirmed')

    }

  end

  def register_failed(resource)
    if resource.errors[:email].include?('has already been taken')
      render json: { message: I18n.t('devise.registrations.email_exists') }, status: :unprocessable_entity
    elsif resource.errors[:password].include?('is too short (minimum is 6 characters)')
      render json: { message: I18n.t('devise.registrations.short_password') }, status: :unprocessable_entity
    elsif resource.errors[:password_confirmation].include?('doesn\'t match Password')
      render json: { message: I18n.t('devise.registrations.matching_password') }, status: :unprocessable_entity
    else
      render json: { message: I18n.t('devise.failure_general_error'), errors: resource.errors }, status: :unprocessable_entity
    end
  end
end
