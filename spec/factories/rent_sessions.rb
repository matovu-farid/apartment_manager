# frozen_string_literal: true

FactoryBot.define do
  factory :rent_session do
    paymentDueDate { '2024-06-17 15:45:07' }
    resident { nil }
    apartment { nil }
    isPaid { false }
  end
end
