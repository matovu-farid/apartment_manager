# frozen_string_literal: true

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
    lambda { |user|
      includes(apartment: { block: { block_admins: :user } })
        .where({ users: { id: user.id } })
    }
  )
  scope(
    :filter_by_viewer,
    lambda { |user|
      includes(apartment: { block: { block_viewers: :user } })
        .where({ users: { id: user.id } })
    }
  )

  def occupy
    apartment.isOccupied = true
    rent_session = RentSession.new(paymentDueDate: startdate, resident: self, apartment:)
    begin
      Resident.transaction do
        save!
        rent_session.save!
        apartment.save!
      end

      true
    rescue Resident::RecordInvalid
      false
    end
  end

  def rent
    apartment.price
  end

  def current_rent_session
    rent_session = rent_sessions.with_in_current_month.first
    if rent_session.nil?

      paymentDueDate = Time.zone.today.change(day: startdate.day)
      paymentDueDate += 1.month if paymentDueDate < Time.zone.today
      rent_session = RentSession.create(
        paymentDueDate:,
        resident: self,
        apartment:
      )
    end

    rent_session
  end

  def current_month_payment
    current_rent_session.payment_total
  end

  delegate :payment_total, to: :rent_sessions

  def current_month_due
    apartment.price
  end

  delegate :total_due, to: :rent_sessions

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
