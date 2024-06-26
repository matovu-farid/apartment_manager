class RentSession < ApplicationRecord
  belongs_to :resident
  belongs_to :apartment
  has_many :payments, dependent: :destroy
  has_many :users, through: :resident
  alias_attribute :admins, :users
  scope(
    :filter_by_admin,
    -> (user) {
      RentSession
        .joins(resident: {apartment: {block: {block_admins: :user}}})
        .includes(resident: {apartment: {block: {block_admins: :user}}})
        .where({users: {id: user.id}})
    }
  )

end
