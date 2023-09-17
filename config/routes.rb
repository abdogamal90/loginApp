Rails.application.routes.draw do
  resources :articles
  devise_for :users,
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
  }
  post 'validate_token', to: 'tokens#validate'
  



  

end
