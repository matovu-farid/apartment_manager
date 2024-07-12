module Adminable
  extend ActiveSupport::Concern

  included do
    def isAdmin?(user)
     self.admins.include?(user)
    end

  end


  class_methods do
    
  end
end
