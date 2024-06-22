class RemoveIsPaidFromRentSessions < ActiveRecord::Migration[7.0]
  def change
    remove_column :rent_sessions, :isPaid, :boolean
  end
end
