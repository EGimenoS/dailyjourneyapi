# frozen_string_literal: true

Rails.application.routes.draw do
  resources :chat_messages
  api_guard_routes for: 'users', controller: {
    registration: 'users/registration',
    authentication: 'users/authentication',
    passwords: 'users/passwords',
    tokens: 'users/tokens'
  }
  namespace :api do
    namespace :v1 do
      resources :travels, only: %i[create index show]
      resources :search_addresses, only: [:index]
      resources :chat_messages, only: %i[create index]
    end
  end
end
