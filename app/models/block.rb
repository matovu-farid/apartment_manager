class Block < ApplicationRecord
  has_many :apartments
  has_many :block_admins
  has_many :users, through: :block_admins
  
end
