# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :block_admins, dependent: :destroy
  has_many :blocks, through: :block_admins
  has_many :apartments, through: :blocks
  has_many :residents, through: :apartments
end
