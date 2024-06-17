class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :rent_session, null: false, foreign_key: true
      t.datetime :date
      t.bigint :amount

      t.timestamps
    end
  end
end
