# frozen_string_literal: true

json.extract! block, :id, :name,  :user_id, :created_at, :updated_at
json.url block_url(block, format: :json)
