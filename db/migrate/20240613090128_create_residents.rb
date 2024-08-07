# frozen_string_literal: true

class CreateResidents < ActiveRecord::Migration[7.0]
  def change
    create_table :residents do |t|
      t.string :name
      t.string :physicalId
      t.string :phonenumber
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :residents, :name
  end
end
