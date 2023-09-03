# app/mailers/custom_devise_mailer.rb
class CustomDeviseMailer < Devise::Mailer
  helper :application # You can include application-specific helpers here

  def confirmation_instructions(record, token, opts = {})
    # Customize email subject, from, and other options if needed
    opts[:subject] = 'Custom Confirmation Instructions'
    opts[:from] = 'custom@example.com'

    super
  end
end
