# frozen_string_literal: true

class CreateApartments < ActiveRecord::Migration[7.0]
  def change
    create_table :apartments do |t|
      t.integer :price
      t.string :floor
      t.integer :apartmentnumber

      t.timestamps
    end
  end
end
