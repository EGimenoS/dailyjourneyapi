# frozen_string_literal: true

class User < ApplicationRecord
  after_create :set_user_gravatar
  has_many :travels, foreign_key: :owner_id, class_name: 'Travel', dependent: :destroy
  has_many :chat_messages, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates_presence_of :name, on: :create

  def jwt_token_payload
    { name: name, avatar: avatar }
  end

  def set_user_gravatar
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    update_attributes(avatar: "http://secure.gravatar.com/avatar/#{gravatar_id}?s=32&d=https%3A%2F%2Fui-avatars.com%2Fapi%2F/#{name}/128")
  end
end
