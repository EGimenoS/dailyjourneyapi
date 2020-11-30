# frozen_string_literal: true

class ChatMessage < ApplicationRecord
  belongs_to :travel, inverse_of: :chat_messages
  belongs_to :user
end
