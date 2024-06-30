class RentSession < ApplicationRecord
  belongs_to :resident
  belongs_to :apartment
  has_many :payments, dependent: :destroy
  has_many :users, through: :resident
  alias_attribute :admins, :users
  scope(
    :filter_by_admin,
    -> (user) {
      RentSession
        .joins(resident: {apartment: {block: {block_admins: :user}}})
        .includes(resident: {apartment: {block: {block_admins: :user}}})
        .where({users: {id: user.id}})
    }
  )
  current_month_start = (Date.today.beginning_of_month).beginning_of_month

  scope(
    :with_in_current_month,
    -> { RentSession.where(paymentDueDate: current_month_start..current_month_start.end_of_month) }
  )

  def payment_total
    payments.sum(:amount)
  end

end
