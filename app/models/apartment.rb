class Apartment < ApplicationRecord
  include Adminable
  validates :price, presence: true 
  validates :floor, presence: true
  validates :name, presence: true
  belongs_to :block
  has_many :rent_sessions
  has_many :users, through: :block
  alias_attribute :admins, :users
  scope :filter_by_admin, ->(user) { Apartment.joins(block: {block_admins: :user}).includes(block: {block_admins: :user}).where({users:{id: user.id}})}
end
