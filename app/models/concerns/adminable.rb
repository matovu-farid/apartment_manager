# frozen_string_literal: true

module Adminable
  extend ActiveSupport::Concern

  included do
    def isAdmin?(user)
      admins.include?(user)
    end
  end

  class_methods do
  end
end
