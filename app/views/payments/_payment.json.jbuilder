# frozen_string_literal: true

json.extract! payment, :id, :rent_session_id, :date, :amount, :created_at, :updated_at
json.url payment_url(payment, format: :json)
