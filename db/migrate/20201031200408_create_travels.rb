# frozen_string_literal: true

class CreateTravels < ActiveRecord::Migration[6.0]
  def change
    create_table :travels do |t|
      t.references :owner, index: true, foreign_key: { to_table: :users }
      t.datetime :departure_time
      t.integer :capacity
      t.text :owner_comment
    end
  end
end
