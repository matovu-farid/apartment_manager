class Apartment < ApplicationRecord
  include Adminable
  validates :price, presence: true
  validates :floor, presence: true
  validates :name, presence: true
  belongs_to :block
  has_many :users, through: :block
  alias_attribute :admins, :users
  scope(
    :filter_by_admin,
    -> (user) {
      joins(block: {block_admins: :user}).includes(block: {block_admins: :user}).where(
        {users: {id: user.id}}
      )
    }
  )
  has_one :resident, dependent: :destroy

end
