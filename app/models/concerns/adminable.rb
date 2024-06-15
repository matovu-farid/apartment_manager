module Adminable
  extend ActiveSupport::Concern

  included do
    def isAdmin?(user)
      puts "-------------------"
      puts 'In module isAdmin?'
      puts "-------------------"
     self.admins.include?(user)
    end

  end


  class_methods do
    
  end
end
