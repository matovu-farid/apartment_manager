class AddNameToApartment < ActiveRecord::Migration[7.0]
  def change
    add_column :apartments, :name, :string
  end
end
