module PaymentsHelper
  include RentSessionsHelper

  def maxPayment(rent_session, current = 0)
    puts("-----------------")
    puts("rent_left: #{rentLeft(rent_session)} ,current: #{current}")
    puts("-----------------")
    rentLeft(rent_session) + current
  end
end
