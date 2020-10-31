# frozen_string_literal: true

class Particpant < ApplicationRecord
  belongs_to :travel
  belongs_to :user
end
