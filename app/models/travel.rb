# frozen_string_literal: true

class Travel < ApplicationRecord
  has_many :participants, dependent: :destroy
  has_one :owner, class_name: 'user', foreign_key: 'owner_id'
  has_one :origin
  has_one :destination
end
