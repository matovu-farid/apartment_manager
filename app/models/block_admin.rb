# frozen_string_literal: true

class BlockAdmin < ApplicationRecord
  belongs_to :user
  belongs_to :block
end
