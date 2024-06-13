class ChangePaymentDueDateInRentSessions < ActiveRecord::Migration[7.0]
  def change
    def up
      change_column :rent_sessions, :paymentduedate, :datetime
    end

    def down
      change_column :rent_sessions, :paymentduedate, :string
    end
  end
end
