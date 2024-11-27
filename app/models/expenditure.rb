class Expenditure < ApplicationRecord
  validates :date, presence: true
  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :category, presence: true

  has_and_belongs_to_many :blocks
  has_many :admins, through: :blocks
  has_many :viewers, through: :blocks

  # Scopes for authorization
  scope :filter_by_admin, ->(user) {
    joins(blocks: { block_admins: :user })
      .includes(blocks: { block_admins: :user })
      .where(users: { id: user.id })
      .distinct
  }

  scope :filter_by_viewer, ->(user) {
    joins(blocks: { block_viewers: :user })
      .includes(blocks: { block_viewers: :user })
      .where(users: { id: user.id })
      .distinct
  }

  # Class method to get unique categories
  def self.categories
    distinct.pluck(:category).compact.sort
  end
end
