class RentSession < ApplicationRecord
  belongs_to :resident
  belongs_to :apartment
  has_many :payments, dependent: :destroy
end
