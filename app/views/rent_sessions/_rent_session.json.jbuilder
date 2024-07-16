# frozen_string_literal: true

json.extract! rent_session, :id, :paymentDueDate, :resident_id, :apartment_id, :isPaid, :created_at, :updated_at
json.url rent_session_url(rent_session, format: :json)
