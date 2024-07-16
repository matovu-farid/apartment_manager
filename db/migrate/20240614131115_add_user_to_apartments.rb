# frozen_string_literal: true

class AddUserToApartments < ActiveRecord::Migration[7.0]
  def change
    add_reference :apartments, :user, null: false, foreign_key: true
  end
end
