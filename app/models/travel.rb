# frozen_string_literal: true

class Travel < ApplicationRecord
  validates_presence_of :departure_time, :capacity, :owner_comment, :owner_id
  validates_associated :origin, :destination
  validates :origin, presence: true
  validates :destination, presence: true
  has_many :participants, dependent: :destroy
  has_many :chat_messages, dependent: :destroy, inverse_of: :travel
  belongs_to :user, class_name: 'User', foreign_key: 'owner_id'
  has_one :origin,  dependent: :destroy
  has_one :destination,  dependent: :destroy
  accepts_nested_attributes_for :origin, :destination

  scope :near_of, ->(target_lat, target_lng, distance) { joins(:destination).merge(Destination.near([target_lat, target_lng], distance)) }
end
