class AddBlockToExpenditure < ActiveRecord::Migration[7.0]
  def change
    add_reference :expenditures, :block, null: false, foreign_key: true
  end
end
