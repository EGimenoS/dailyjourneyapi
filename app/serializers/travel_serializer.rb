# frozen_string_literal: true

class TravelSerializer < BaseSerializer
  attributes :departure_time, :owner_comment, :capacity, :distance, :bearing
  has_many :participants
  has_one :origin
  has_one :destination
  belongs_to :user, key: :owner
end
