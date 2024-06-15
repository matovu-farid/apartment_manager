class Apartment < ApplicationRecord
  validates :price, presence: true 
  validates :floor, presence: true
  validates :name, presence: true
  belongs_to :block
  has_many :rent_sessions
end
