module RentSessionsHelper
  def totalPayments(rent_session)
    rent_session.payments.sum(:amount)
  end

  def totalRent(rent_session)
    rent_session.apartment.price
  end

  def rentLeft(rent_session)
    totalRent(rent_session) - totalPayments(rent_session)
  end

  def fullyPaid?(rent_session)
    rentLeft(rent_session) <= 0 ? "Yes" : "No"
  end

end
