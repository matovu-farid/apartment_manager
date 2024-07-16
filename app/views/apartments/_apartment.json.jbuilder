# frozen_string_literal: true

json.extract! apartment, :id, :price, :floor, :name, :created_at, :updated_at
json.url apartment_url(apartment, format: :json)
