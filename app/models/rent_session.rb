# frozen_string_literal: true

class RentSession < ApplicationRecord
  include Discard::Model
  belongs_to :resident
  belongs_to :apartment
  has_many(:payments, dependent: :destroy) do
    def payment_total
      payments.sum(:amount)
    end
  end

  has_many :admins, through: :resident
  has_many :viewers, through: :resident
  scope(
    :filter_by_admin,
    lambda { |user|
      joins(resident: {apartment: {block: {block_admins: :user}}})
        .includes(resident: {apartment: {block: {block_admins: :user}}})
        .where({users: {id: user.id}})
    }
  )
  scope(
    :filter_by_viewer,
    lambda { |user|
      joins(resident: {apartment: {block: {block_viewers: :user}}})
        .includes(resident: {apartment: {block: {block_viewers: :user}}})
        .where({users: {id: user.id}})
    }
  )
  scope(
    :payment_total,
    -> { joins(:payments).sum('payments.amount') }
  )

  scope :kept, -> { undiscarded.joins(:resident).merge(Resident.kept) }

  def payment_total
    payments.sum(:amount)
  end

  scope(
    :collectable_rent,
    -> { undiscarded.joins(:apartment).sum(:price) }
  )
  current_month_start = Time.zone.today.beginning_of_month.beginning_of_month
  prev_month_start = current_month_start - 1.month

  scope(
    :with_in_current_month,
    -> { where(paymentDueDate: current_month_start..current_month_start.end_of_month) }
  )
  scope(
    :with_in_prev_month,
    -> { where(paymentDueDate: prev_month_start..prev_month_start.end_of_month) }
  )
  scope(
    :with_in_month,
    lambda { |date| where(paymentDueDate: date.beginning_of_month..date.end_of_month) }
  )
end
