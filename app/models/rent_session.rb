class RentSession < ApplicationRecord
  belongs_to :resident
  belongs_to :apartment
  validates :startdate, presence: true
  validates :paymentDueDate, presence: true
end
