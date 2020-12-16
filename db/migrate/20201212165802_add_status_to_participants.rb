# frozen_string_literal: true

class AddStatusToParticipants < ActiveRecord::Migration[6.0]
  def change
    add_column :participants, :status, :integer, default: 0
  end
end
