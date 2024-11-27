class Expenditure < ApplicationRecord
  include Adminable
  validates :date, presence: true
  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :category, presence: true

  belongs_to :block
  has_many :admins, through: :block
  has_many :viewers, through: :block
  scope(
    :filter_by_admin,
    lambda { |user|
      joins(block: { block_admins: :user }).includes(block: { block_admins: :user }).where(
        { users: { id: user.id } }
      )
    }
  )
  scope(
    :filter_by_viewer,
    lambda { |user|
      joins(block: { block_viewers: :user }).includes(block: { block_viewers: :user }).where(
        { users: { id: user.id } }
      )
    }
  )

  # Class method to get unique categories
  def self.categories
    distinct.pluck(:category).compact.sort
  end
end
