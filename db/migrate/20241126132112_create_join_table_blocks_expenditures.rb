class CreateJoinTableBlocksExpenditures < ActiveRecord::Migration[7.0]
  def change
    create_join_table :blocks, :expenditures do |t|
      t.index [:block_id, :expenditure_id]
      t.index [:expenditure_id, :block_id]
    end
  end
end
