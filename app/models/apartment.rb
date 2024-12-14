# frozen_string_literal: true

class Apartment < ApplicationRecord
  include Adminable
  validates :price, presence: true
  validates :floor, presence: true
  validates :name, presence: true, uniqueness: { scope: :block_id }
  belongs_to :block
  has_many :admins, through: :block
  has_many :viewers, through: :block
  has_many :rent_sessions, dependent: :destroy
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

  scope(
    :visible,
    lambda {
      where(hidden: false)
    }
  )

  scope(
    :is_occupied,
    -> {
      joins(:rent_sessions).merge(RentSession.kept)
    }
  )

  scope(
    :is_unoccupied,
    lambda {
      where.missing(:rent_sessions)
    }
  )

  def is_occupied?
    rent_sessions.any?
  end

  has_one :resident, dependent: :destroy
end
