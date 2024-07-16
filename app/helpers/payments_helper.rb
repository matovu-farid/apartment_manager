# frozen_string_literal: true

module PaymentsHelper
  include RentSessionsHelper

  def maxPayment(rent_session, current = 0)
    rentLeft(rent_session) + current
  end

end
