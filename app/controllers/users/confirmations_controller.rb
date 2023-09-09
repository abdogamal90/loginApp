class Users::ConfirmationsController < Devise::ConfirmationsController
  private
  def after_confirmation_path_for(resource_name, resource)
    return "http://localhost:3001/sign_in"
  end

  
end