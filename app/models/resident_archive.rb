class ResidentArchive < ApplicationRecord
  belongs_to :resident
  belongs_to :apartment
end
