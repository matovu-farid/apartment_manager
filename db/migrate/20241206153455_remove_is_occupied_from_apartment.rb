class RemoveIsOccupiedFromApartment < ActiveRecord::Migration[7.0]
  def change
    remove_column :apartments, :isOccupied, :boolean
  end
end
