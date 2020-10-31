# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /api/v1/users' do
    let(:user_params) do
      { email: 'testuser@test.com', password: 'testpassword', password_confirmation: 'testpassword', name: 'Test User' }
    end
    it 'create a new user' do
      headers = { 'Content-Type': 'application/json' }
      post user_sign_up_path, params: user_params, headers: { headers: headers }
      expect(response).to have_http_status(:success)
      expect(load_body(response)['message']).to include('Signed up successfully')
    end
    it 'returns unprocessable entity with errors' do
      headers = { 'Content-Type': 'application/json' }
      user_params[:password] = nil
      post user_sign_up_path, params: user_params, headers: { headers: headers }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(load_body(response)['error']).to include("can't be blank")
    end
  end
end
