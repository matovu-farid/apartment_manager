# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :rent_session
  has_one :resident, through: :rent_session
  has_one :apartment, through: :rent_session

  has_many :admins, through: :rent_session
  has_many :viewers, through: :rent_session

  scope(
    :filter_by_admin,
    lambda { |user|
      joins(rent_session: {resident: {apartment: {block: {block_admins: :user}}}})
        .includes(rent_session: {resident: {apartment: {block: {block_admins: :user}}}})
        .where({users: {id: user.id}})
    }
  )
  scope(
    :filter_by_viewer,
    lambda { |user|
      joins(rent_session: {resident: {apartment: {block: {block_viewers: :user}}}})
        .includes(rent_session: {resident: {apartment: {block: {block_viewers: :user}}}})
        .where({users: {id: user.id}})
    }
  )
end
