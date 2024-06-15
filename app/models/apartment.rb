class Apartment < ApplicationRecord
  validates :price, presence: true 
  validates :floor, presence: true
  validates :apartmentnumber, presence: true
  belongs_to :block
  has_many :rent_sessions
end
