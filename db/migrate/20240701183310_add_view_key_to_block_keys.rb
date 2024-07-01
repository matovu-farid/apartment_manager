class AddViewKeyToBlockKeys < ActiveRecord::Migration[7.0]
  def change
    add_column(:block_keys, :viewkey, :string, null: false, default: -> { "gen_random_uuid()" })
    add_index(:block_keys, :viewkey, unique: true)
  end
end
