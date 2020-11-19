# frozen_string_literal: true

class User < ApplicationRecord
  has_many :travels, foreign_key: :owner_id, class_name: 'Travel', dependent: :destroy
  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates_presence_of :name, on: :create

  def jwt_token_payload
    { name: name }
  end
end
