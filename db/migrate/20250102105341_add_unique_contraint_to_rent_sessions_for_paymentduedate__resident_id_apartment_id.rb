class AddUniqueContraintToRentSessionsForPaymentduedateResidentIdApartmentId < ActiveRecord::Migration[7.0]
  def change
    add_index :rent_sessions, [:paymentDueDate, :resident_id, :apartment_id], unique: true, name: 'unique_rent_session_index'
  end
end
