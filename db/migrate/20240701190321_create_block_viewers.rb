# frozen_string_literal: true

class CreateBlockViewers < ActiveRecord::Migration[7.0]
  def change
    create_table(:block_viewers) do |t|
      t.references(:user, null: false, foreign_key: true)
      t.references(:block, null: false, foreign_key: true)

      t.timestamps
    end

    add_index(:block_viewers, %i[user_id block_id], unique: true)
  end
end
