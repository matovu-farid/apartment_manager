class Block < ApplicationRecord
  has_many :apartments, dependent: :destroy
  has_many :block_admins, dependent: :destroy
  has_many :block_viewers, dependent: :destroy

  has_one :block_key, dependent: :destroy
  has_many :users, through: :block_admins
  has_many :viewers, through: :block_viewers, source: :user
  alias_attribute :admins, :users

  scope :filter_by_admin, -> (user) { includes(:block_admins).where(block_admins: {user: user}) }
  scope :filter_by_viewer, -> (user) { includes(:block_viewers).where(block_viewers: {user: user}) }
end
