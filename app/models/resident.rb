class Resident < ApplicationRecord
  validates :name, presence: true
  validates :physicalId, presence: true
  validates :phonenumber, presence: true
  has_many :rent_sessions
end
