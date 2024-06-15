class Apartment < ApplicationRecord
  include Adminable
  validates :price, presence: true 
  validates :floor, presence: true
  validates :name, presence: true
  belongs_to :block
  has_many :rent_sessions
  has_many :users, through: :block
  alias_attribute :admins, :users
end
