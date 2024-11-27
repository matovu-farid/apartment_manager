class CreateExpenditures < ActiveRecord::Migration[7.0]
  def change
    create_table :expenditures do |t|
      t.date :date
      t.string :name
      t.string :reference
      t.text :description
      t.integer :amount
      t.string :category

      t.timestamps
    end
    
    add_index :expenditures, :category
  end
end
