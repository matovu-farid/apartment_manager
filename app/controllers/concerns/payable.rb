module Payable 
  extend ActiveSupport::Concern

  included do
    require 'date'

    def payment_due_date(date)
      # Get the next month
      next_month = date.next_month

      # Handle edge cases for months with fewer days
      if date.day > 28
        begin
          Date.new(next_month.year, next_month.month, date.day)
        rescue Date::Error
          Date.new(next_month.year, next_month.month, -1) # Last day of next month if day doesn't exist
        end
      else
        # Use the same day for other months
        Date.new(next_month.year, next_month.month, date.day)
      end
    end
  end



  class_methods do
  end
end
