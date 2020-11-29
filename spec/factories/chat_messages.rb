# frozen_string_literal: true

FactoryBot.define do
  factory :chat_message do
    travel { nil }
    user { nil }
    message { 'MyText' }
  end
end
