# frozen_string_literal: true

class Api::V1::UsersController < Api::V1::BaseController
  before_action :authenticate_and_set_user
  def show
    render_object(current_user, :ok)
  end

  def update
    if current_user.update(user_params)
      create_token_and_set_header(current_user, 'user')
      render_object(current_user, :ok)
    else
      render_errors(current_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
