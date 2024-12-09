class AddHiddenToApartment < ActiveRecord::Migration[7.0]
  def change
    add_column :apartments, :hidden, :boolean, default: false
  end
end
