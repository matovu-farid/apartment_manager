class RemoveUserFromApartment < ActiveRecord::Migration[7.0]
  def change
    remove_reference :apartments, :user, null: false, foreign_key: true
  end
end
