# frozen_string_literal: true

class Admin < ApplicationRecord
  belongs_to :user
  belongs_to :apartment
end
