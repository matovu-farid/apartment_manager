# frozen_string_literal: true

class AddBlockToApartment < ActiveRecord::Migration[7.0]
  def change
    add_reference :apartments, :block, null: false, foreign_key: true
  end
end
