class RentSession < ApplicationRecord
  belongs_to :resident
  belongs_to :apartment
end
