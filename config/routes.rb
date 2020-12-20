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
      resources :travels
      resource :user, only: [:update]
      resources :search_addresses, only: [:index]
      resources :chat_messages, only: %i[create index]
      resources :participants
      resources :profile_travels, only: [:index]
    end
  end
end
