# frozen_string_literal: true

class Add < ActiveRecord::Migration[6.0]
  def change
    add_timestamps :travels
  end
end
