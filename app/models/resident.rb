class Resident < ApplicationRecord
  validates :name, presence: true
  validates :physicalId, presence: true
  validates :phonenumber, presence: true
  belongs_to :apartment
  has_many :admins, through: :apartment
  has_many :viewers, through: :apartment
  has_many :rent_sessions, dependent: :destroy
  has_many :payments, through: :rent_sessions
  accepts_nested_attributes_for :rent_sessions

  scope(
    :filter_by_admin,
    -> (user) {
      includes(apartment: {block: {block_admins: :user}})
        .where({users: {id: user.id}})
    }
  )
  scope(
    :filter_by_viewer,
    -> (user) {
      includes(apartment: {block: {block_viewers: :user}})
        .where({users: {id: user.id}})
    }
  )

  def rent
    apartment.price
  end

  def current_rent_session
    rent_session = rent_sessions.with_in_current_month.first
    if rent_session.nil?

      paymentDueDate = Date.today.change(day: startdate.day)
      paymentDueDate = paymentDueDate + 1.month if paymentDueDate < Date.today
      rent_session = RentSession.create(
        paymentDueDate: paymentDueDate,
        resident: self,
        apartment: apartment
      )
    end

    rent_session
  end

  def current_month_payment
    current_rent_session.payment_total
  end

  def payment_total
    rent_sessions.payment_total
  end

  def current_month_due
    apartment.price
  end

  def total_due
    rent_sessions.total_due
  end

  def rent_balance
    total_due - payment_total
  end

  def has_paid_total_due?
    payment_total >= total_due
  end

  def has_paid_current_month?
    current_month_payment >= current_month_due
  end
end
