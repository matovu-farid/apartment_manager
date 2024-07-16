# frozen_string_literal: true

class AddApartmentIdToResident < ActiveRecord::Migration[7.0]
  def change
    add_reference(:residents, :apartment, null: false, index: { unique: true }, foreign_key: { on_delete: :cascade })
  end
end
