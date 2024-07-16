# frozen_string_literal: true

FactoryBot.define do
  factory :block_key do
    block { nil }
    key { 'MyString' }
  end
end
