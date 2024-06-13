json.extract! rent_session, :id, :startdate, :paymentDueDate, :resident_id, :apartment_id, :created_at, :updated_at
json.url rent_session_url(rent_session, format: :json)
