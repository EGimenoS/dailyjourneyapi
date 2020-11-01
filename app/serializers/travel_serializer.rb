# frozen_string_literal: true

class TravelSerializer < BaseSerializer
  attributes :departure_time, :owner_comment, :capacity
  has_many :participants
  has_one :origin
  has_one :destination
  belongs_to :owner, class_name: 'user', foreign_key: 'owner_id'
end
