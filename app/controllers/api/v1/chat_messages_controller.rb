# frozen_string_literal: true

class Api::V1::ChatMessagesController < Api::V1::BaseController
  before_action :authenticate_and_set_user, only: %i[create]
  def index
    chat_messages = ChatMessage.where(travel_id: params[:travel_id])
    render_object(chat_messages, :created)
  end

  def create
    message = current_user.chat_messages.build(message_params)
    if message.save
      render_object(message, :created)
    else
      render_errors(message.errors)
    end
  end

  private

  def message_params
    params.require(:chat_message).permit(:message, :travel_id)
  end
end
