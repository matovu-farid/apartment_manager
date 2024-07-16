# frozen_string_literal: true

class BlockViewer < ApplicationRecord
  belongs_to :user
  belongs_to :block
end
