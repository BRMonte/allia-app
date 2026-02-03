require "rails_helper"

RSpec.describe TreatmentPlan, type: :model do
  it "is valid with valid attributes" do
    patient = Patient.create!(
      first_name: "John",
      last_name: "Doe",
      email: "john_tp@example.com",
      date_of_birth: Date.new(1990, 1, 1)
    )

    treatment_plan = TreatmentPlan.new(
      name: "Plan A",
      status: :active,
      start_date: Date.today,
      patient: patient
    )

    expect(treatment_plan).to be_valid
  end

  it "is invalid without name" do
    treatment_plan = TreatmentPlan.new(start_date: Date.today, status: :active)
    expect(treatment_plan).not_to be_valid
  end

  it "is invalid without start_date" do
    treatment_plan = TreatmentPlan.new(name: "Plan", status: :active)
    expect(treatment_plan).not_to be_valid
  end

  it "is invalid without status" do
    treatment_plan = TreatmentPlan.new(name: "Plan", start_date: Date.today)
    expect(treatment_plan).not_to be_valid
  end

  it "is invalid without patient" do
    treatment_plan = TreatmentPlan.new(
      name: "Plan",
      start_date: Date.today,
      status: :active
    )

    expect(treatment_plan).not_to be_valid
  end

  it "is invalid when end_date is before start_date" do
    patient = Patient.create!(
      first_name: "Jane",
      last_name: "Doe",
      email: "jane_tp@example.com",
      date_of_birth: Date.new(1990, 1, 1)
    )

    treatment_plan = TreatmentPlan.new(
      name: "Plan B",
      status: :active,
      start_date: Date.today,
      end_date: Date.yesterday,
      patient: patient
    )

    expect(treatment_plan).not_to be_valid
  end
end
