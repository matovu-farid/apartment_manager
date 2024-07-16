# frozen_string_literal: true

class RemoveUserFromResidents < ActiveRecord::Migration[7.0]
  def change
    remove_reference :residents, :user, null: false, foreign_key: true
  end
end
