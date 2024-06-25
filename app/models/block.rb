class Block < ApplicationRecord
  has_many :apartments, dependent: :destroy
  has_many :block_admins, dependent: :destroy
  has_one :block_key, dependent: :destroy
  has_many :users, through: :block_admins
  alias_attribute :admins, :users

  scope :filter_by_admin, -> (user) { Block.includes(:block_admins).where(block_admins: {user: user}) }
end
