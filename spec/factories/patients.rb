FactoryBot.define do
  factory :patient do
    sequence(:email) { |n| "patient#{n}@example.com" }
    first_name { "John" }
    last_name  { "Doe" }
    date_of_birth { 30.years.ago.to_date }
  end
end
