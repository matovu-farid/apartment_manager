# frozen_string_literal: true

class AddIndexNameToApartment < ActiveRecord::Migration[7.0]
  def change
    add_index :apartments, :name
  end
end
