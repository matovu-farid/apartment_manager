class RemoveIndexResidentsOnApartmentId < ActiveRecord::Migration[7.0]
  def change
    remove_index :residents, :apartment_id
    add_index :residents, :apartment_id, unique: false
  end
end
