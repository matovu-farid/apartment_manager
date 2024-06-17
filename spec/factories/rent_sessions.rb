FactoryBot.define do
  factory :rent_session do
    paymentDueDate { "2024-06-17 13:19:24" }
    resident { nil }
    apartment { nil }
    isPaid { false }
  end
end
