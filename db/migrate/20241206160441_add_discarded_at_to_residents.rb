class AddDiscardedAtToResidents < ActiveRecord::Migration[7.0]
  def change
    add_column :residents, :discarded_at, :datetime
    add_index :residents, :discarded_at
  end
end
