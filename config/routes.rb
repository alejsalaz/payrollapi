Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :v1, default: { format: 'json' } do
    resources :users
    post '/auth/login', to: 'authentication#login'
  end
end
