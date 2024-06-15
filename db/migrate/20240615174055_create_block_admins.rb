class CreateBlockAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :block_admins do |t|
      t.references :user, null: false, foreign_key: true
      t.references :block, null: false, foreign_key: true

      t.timestamps
    end
  end
end
