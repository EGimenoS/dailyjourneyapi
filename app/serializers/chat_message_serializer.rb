# frozen_string_literal: true

class ChatMessageSerializer < BaseSerializer
  attributes :message, :created_at
  has_one :user
end
