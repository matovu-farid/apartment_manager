# frozen_string_literal: true

class Block < ApplicationRecord
  has_many :apartments, dependent: :destroy
  has_many :block_admins, dependent: :destroy
  has_many :block_viewers, dependent: :destroy

  has_one :block_key, dependent: :destroy
  has_many :admins, through: :block_admins, source: :user
  has_many :viewers, through: :block_viewers, source: :user

  scope :filter_by_admin, ->(user) { includes(:block_admins).where(block_admins: { user: }) }
  scope :filter_by_viewer, ->(user) { includes(:block_viewers).where(block_viewers: { user: }) }

  def remove_admin(user)
    return unless admins.include?(user)

    block_admins.find_by(user:).destroy
  end
end
