class CreateResidentArchives < ActiveRecord::Migration[7.0]
  def change
    create_table :resident_archives do |t|
      t.references :resident, null: false, foreign_key: true
      t.references :apartment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
