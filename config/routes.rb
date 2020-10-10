# frozen_string_literal: true

Rails.application.routes.draw do
  api_guard_routes for: 'users'
end
