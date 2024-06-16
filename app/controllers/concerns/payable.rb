module Payable 
  extend ActiveSupport::Concern

  included do
    require 'date'
    def payment_due_date_from_start_date(start_date)
      current_day = Date.today
      projected_date = nil
      begin
        projected_date =  Date.new(current_day.year, current_day.month, start_date.day)
      rescue Date::Error
        projected_date =  Date.new(current_day.year, current_day.month, -1)
      end
      payment_due_date(projected_date)
    end

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
