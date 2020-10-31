# frozen_string_literal: true

class CreateOrigins < ActiveRecord::Migration[6.0]
  def change
    create_table :origins do |t|
      t.float :longitude
      t.float :latitude
      t.string :address
      t.references :travel, foreign_key: true
      t.timestamps
    end
  end
end
