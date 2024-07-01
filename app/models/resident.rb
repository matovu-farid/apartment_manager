class Resident < ApplicationRecord
  validates :name, presence: true
  validates :physicalId, presence: true
  validates :phonenumber, presence: true
  belongs_to :apartment
  has_many :users, through: :apartment
  alias_attribute :admins, :users
  has_many :rent_sessions, dependent: :destroy
  has_many :payments, through: :rent_sessions
  accepts_nested_attributes_for :rent_sessions

  scope(
    :filter_by_admin,
    -> (user) {

      joins(apartment: {block: {block_admins: :user}})
        .includes(apartment: {block: {block_admins: :user}})
        .where({users: {id: user.id}})
    }
  )

  def current_rent_session
    rent_sessions.with_in_current_month.first
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

  def has_paid_total_due?
    payment_total >= total_due
  end

  def has_paid_current_month?
    current_month_payment >= current_month_due
  end
end
