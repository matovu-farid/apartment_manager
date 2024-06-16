class AddApartmentIdToResident < ActiveRecord::Migration[7.0]
  def change
    add_reference :residents, :apartment, null: false, foreign_key: true
  end
end
