class AddIsOccupiedToApartment < ActiveRecord::Migration[7.0]
  def change
    add_column :apartments, :isOccupied, :boolean, default: false
  end
end
