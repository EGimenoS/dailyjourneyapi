# frozen_string_literal: true

Rails.application.routes.draw do
  api_guard_routes for: 'users', controller: {
    registration: 'users/registration',
    authentication: 'users/authentication',
    passwords: 'users/passwords',
    tokens: 'users/tokens'
  }
  namespace :api do
    namespace :v1 do
      # resources :users, only: [:create]
    end
  end
end
