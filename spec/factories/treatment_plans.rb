FactoryBot.define do
  factory :treatment_plan do
    name { "Test Treatment Plan" }
    status { :active }
    start_date { Date.today }
    end_date { nil }
    association :patient
  end
end
