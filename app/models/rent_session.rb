class RentSession < ApplicationRecord
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
    -> (user) {
      joins(resident: {apartment: {block: {block_admins: :user}}})
        .includes(resident: {apartment: {block: {block_admins: :user}}})
        .where({users: {id: user.id}})
    }
  )
  scope(
    :filter_by_viewer,
    -> (user) {
      joins(resident: {apartment: {block: {block_viewers: :user}}})
        .includes(resident: {apartment: {block: {block_viewers: :user}}})
        .where({users: {id: user.id}})
    }
  )
  scope(
    :payment_total,
    -> { joins(:payments).sum(:amount) }
  )

  scope(
    :total_due,
    -> { joins(:apartment).sum(:price) }
  )
  current_month_start = (Date.today.beginning_of_month).beginning_of_month
  prev_month_start = current_month_start - 1.month

  scope(
    :with_in_current_month,
    -> { where(paymentDueDate: current_month_start..current_month_start.end_of_month) }
  )
  scope(
    :with_in_prev_month,
    -> { where(paymentDueDate: prev_month_start..prev_month_start.end_of_month) }
  )

end
