class CreateRentSessions < ActiveRecord::Migration[7.0]
  def change
    drop_table :rent_sessions
    create_table :rent_sessions do |t|
      t.datetime :paymentDueDate
      t.references :resident, null: false, foreign_key: true
      t.references :apartment, null: false, foreign_key: true
      t.boolean :isPaid, default: false
      t.timestamps
    end
  end
end
