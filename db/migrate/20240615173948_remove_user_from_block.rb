# frozen_string_literal: true

class RemoveUserFromBlock < ActiveRecord::Migration[7.0]
  def change
    remove_reference :blocks, :user, null: false, foreign_key: true
  end
end
