# spec/models/patient_spec.rb
require "rails_helper"

RSpec.describe Patient, type: :model do
  it "is valid with valid attributes" do
    patient = Patient.new(
      first_name: "John",
      last_name: "Doe",
      email: "john@example.com",
      date_of_birth: Date.new(1990, 1, 1)
    )

    expect(patient).to be_valid
  end

  it "is invalid without first_name" do
    patient = Patient.new(last_name: "Doe", email: "a@b.com", date_of_birth: Date.today)
    expect(patient).not_to be_valid
  end

  it "is invalid without last_name" do
    patient = Patient.new(first_name: "John", email: "a@b.com", date_of_birth: Date.today)
    expect(patient).not_to be_valid
  end

  it "is invalid without date_of_birth" do
    patient = Patient.new(first_name: "John", last_name: "Doe", email: "a@b.com")
    expect(patient).not_to be_valid
  end

  it "is invalid without email" do
    patient = Patient.new(first_name: "John", last_name: "Doe", date_of_birth: Date.today)
    expect(patient).not_to be_valid
  end

  it "is invalid with duplicated email" do
    Patient.create!(
      first_name: "Jane",
      last_name: "Doe",
      email: "dup@example.com",
      date_of_birth: Date.today
    )

    patient = Patient.new(
      first_name: "John",
      last_name: "Doe",
      email: "dup@example.com",
      date_of_birth: Date.today
    )

    expect(patient).not_to be_valid
  end

  it "is invalid with malformed email" do
    patient = Patient.new(
      first_name: "John",
      last_name: "Doe",
      email: "invalid",
      date_of_birth: Date.today
    )

    expect(patient).not_to be_valid
  end
end
