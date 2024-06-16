class RemovePaymentDueDateFromRentSession < ActiveRecord::Migration[7.0]
  def change
    remove_column :rent_sessions, :paymentDueDate, :datetime
  end
end
