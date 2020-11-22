# frozen_string_literal: true

class Origin < ApplicationRecord
  belongs_to :travel
  reverse_geocoded_by :latitude, :longitude
  scope :near_of, ->(target_lat, target_lng) { all.near([target_lat, target_lng], 3) }
end
