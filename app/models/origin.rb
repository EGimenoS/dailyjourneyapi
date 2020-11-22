# frozen_string_literal: true

class Origin < ApplicationRecord
  belongs_to :travel
  reverse_geocoded_by :latitude, :longitude
end
