# frozen_string_literal: true

class AddPeriodicityToTravels < ActiveRecord::Migration[6.0]
  def change
    add_column :travels, :periodicity, :string
  end
end
