# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates_presence_of :name, on: :create
end
