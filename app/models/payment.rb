class Payment < ApplicationRecord
  belongs_to :rent_session

  has_many :users, through: :rent_session
  has_many :viewers, through: :rent_session

  alias_attribute :admins, :users
  scope(
    :filter_by_admin,
    -> (user) {

      joins(rent_session: {resident: {apartment: {block: {block_admins: :user}}}})
        .includes(rent_session: {resident: {apartment: {block: {block_admins: :user}}}})
        .where({users: {id: user.id}})
    }
  )
  scope(
    :filter_by_viewer,
    -> (user) {

      joins(rent_session: {resident: {apartment: {block: {block_viewers: :user}}}})
        .includes(rent_session: {resident: {apartment: {block: {block_viewers: :user}}}})
        .where({users: {id: user.id}})
    }
  )

end
