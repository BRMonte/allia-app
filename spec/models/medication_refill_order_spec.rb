require "rails_helper"

RSpec.describe MedicationRefillOrder, type: :model do
  it "is valid with valid attributes" do
    patient = Patient.create!(
      first_name: "John",
      last_name: "Doe",
      email: "john_mro@example.com",
      date_of_birth: Date.new(1990, 1, 1)
    )

    treatment_plan = TreatmentPlan.create!(
      name: "Plan A",
      status: :active,
      start_date: Date.today,
      patient: patient
    )

    order = MedicationRefillOrder.new(
      requested_date: Date.today,
      status: :pending,
      treatment_plan: treatment_plan
    )

    expect(order).to be_valid
  end

  it "is invalid without requested_date" do
    order = MedicationRefillOrder.new(status: :pending)
    expect(order).not_to be_valid
  end

  it "is invalid without status" do
    order = MedicationRefillOrder.new(requested_date: Date.today)
    expect(order).not_to be_valid
  end

  it "is invalid without treatment_plan" do
    order = MedicationRefillOrder.new(
      requested_date: Date.today,
      status: :pending
    )

    expect(order).not_to be_valid
  end
end
