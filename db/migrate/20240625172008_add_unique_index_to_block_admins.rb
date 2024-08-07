# frozen_string_literal: true

class AddUniqueIndexToBlockAdmins < ActiveRecord::Migration[7.0]
  def change
    add_index(:block_admins, %i[user_id block_id], unique: true)
  end
end
