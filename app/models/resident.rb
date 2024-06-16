class Resident < ApplicationRecord
  validates :name, presence: true
  validates :physicalId, presence: true
  validates :phonenumber, presence: true
  belongs_to :apartment
  has_many :users, through: :apartment
  alias_attribute :admins, :users

  # scope :filter_by_admin, ->(user) { Apartment.joins(block: {block_admins: :user}).includes(block: {block_admins: :user}).where({users:{id: user.id}})}
  scope :filter_by_admin, ->(user) { Resident.joins(apartment: {block: {block_admins: :user}}).includes(apartment: {block: {block_admins: :user}}).where({users:{id: user.id}})}
end
