# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :v1 do
    resources :users, :companies
    post '/auth/login', to: 'authentication#login'
  end
end
