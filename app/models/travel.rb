# frozen_string_literal: true

class Travel < ApplicationRecord
  validates_presence_of :departure_time, :capacity, :owner_comment, :owner_id
  has_many :participants, dependent: :destroy
  belongs_to :user, class_name: 'User', foreign_key: 'owner_id'
  has_one :origin
  has_one :destination
end
