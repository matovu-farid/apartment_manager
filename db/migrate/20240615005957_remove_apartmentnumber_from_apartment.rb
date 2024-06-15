class RemoveApartmentnumberFromApartment < ActiveRecord::Migration[7.0]
  def change
    remove_column :apartments, :apartmentnumber, :integer
  end
end
