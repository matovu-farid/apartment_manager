# frozen_string_literal: true

class CreateBlockKeys < ActiveRecord::Migration[7.0]
  def change
    create_table(:block_keys) do |t|
      t.references(:block, null: false, foreign_key: true)
      t.string(:key, null: false, default: -> { 'gen_random_uuid()' })

      t.timestamps
    end

    add_index(:block_keys, :key, unique: true)
  end
end
