# frozen_string_literal: true

class Participant < ApplicationRecord
  belongs_to :travel
  belongs_to :user
  enum status: { pending_approval: 0, approved: 1, rejected: 2 }
end
