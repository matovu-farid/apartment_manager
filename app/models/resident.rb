# frozen_string_literal: true

class Resident < ApplicationRecord
  include Discard::Model
  validates :name, presence: true
  validates :physicalId, presence: true
  validates :phonenumber, presence: true
  belongs_to :apartment
  has_many :admins, through: :apartment
  has_many :viewers, through: :apartment
  has_many :rent_sessions, dependent: :destroy
  has_many :payments, through: :rent_sessions
  accepts_nested_attributes_for :rent_sessions
  attribute :is_not_archived, :boolean, default: true

  scope(
    :filter_by_admin,
    lambda { |user|
      includes(apartment: {block: {block_admins: :user}})
        .where({users: {id: user.id}})
    }
  )
  scope(
    :filter_by_viewer,
    lambda { |user|
      includes(apartment: {block: {block_viewers: :user}})
        .where({users: {id: user.id}})
    }
  )



  def rent
    apartment.price
  end



  def find_or_create_current_rent_session
    rent_session = rent_sessions.with_in_current_month.first
    if rent_session.nil?
      paymentDueDate = Time.zone.today.change(day: startdate.day)
      paymentDueDate += 1.month if paymentDueDate < Time.zone.today
      rent_session = RentSession.create(
        paymentDueDate:,
        resident: self,
        apartment:,
        amount: apartment.price
      )
    end

    rent_session
  end

  def current_month_payment
    find_or_create_current_rent_session.payment_total
  end

  delegate :payment_total, to: :rent_sessions

  delegate :collectable_rent, to: :rent_sessions

  def rent_balance
    collectable_rent - payment_total
  end

  def paid_total_due?
    payment_total >= collectable_rent
  end

  def paid_current_month?
    current_month_payment >= rent
  end
  def self.ransackable_attributes(auth_object = nil)
    ["apartment_id", "id", "name", "phonenumber", "physicalId", "startdate"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["admins", "apartment", "payments", "rent_sessions", "viewers"]
  end
end
