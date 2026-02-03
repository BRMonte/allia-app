FactoryBot.define do
  factory :medication_refill_order do
    requested_date { Date.today }
    status { :pending }
    association :treatment_plan
  end
end
