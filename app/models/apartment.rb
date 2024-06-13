class Apartment < ApplicationRecord
  validates :price, presence: true 
  validates :floor, presence: true
  validates :apartmentnumber, presence: true
  has_many :rent_sessions
end
