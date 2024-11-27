FactoryBot.define do
  factory :expenditure do
    date { "2024-11-26" }
    name { "MyString" }
    reference { "MyString" }
    description { "MyText" }
    amount { 1 }
    category { "MyString" }
  end
end
