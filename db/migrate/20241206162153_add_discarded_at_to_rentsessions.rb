class AddDiscardedAtToRentsessions < ActiveRecord::Migration[7.0]
  def change
    add_column :rent_sessions, :discarded_at, :datetime
    add_index :rent_sessions, :discarded_at
  end
end
