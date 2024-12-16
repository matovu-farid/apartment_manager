class AddAmountToRentSession < ActiveRecord::Migration[7.0]
  def change
    add_column :rent_sessions, :amount, :integer, default: 0
  end
end
