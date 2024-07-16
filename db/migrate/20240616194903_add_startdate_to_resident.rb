# frozen_string_literal: true

class AddStartdateToResident < ActiveRecord::Migration[7.0]
  def change
    add_column :residents, :startdate, :datetime
  end
end
