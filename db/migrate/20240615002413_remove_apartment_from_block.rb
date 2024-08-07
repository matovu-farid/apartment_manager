# frozen_string_literal: true

class RemoveApartmentFromBlock < ActiveRecord::Migration[7.0]
  def change
    remove_reference :blocks, :apartment, null: false, foreign_key: true
  end
end
