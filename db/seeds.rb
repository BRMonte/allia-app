100.times do |i|
  patient = Patient.create!(
    first_name: "Patient#{i}",
    last_name: "Test",
    email: "patient#{i}@example.com",
    date_of_birth: Date.today - rand(18..80).years
  )

  rand(1..3).times do |j|
    treatment_plan = TreatmentPlan.create!(
      patient: patient,
      name: "Treatment #{j + 1}",
      status: rand(0..1),
      start_date: Date.today - rand(10..180).days,
      end_date: rand < 0.5 ? nil : Date.today + rand(30..180).days
    )

    rand(1..5).times do
      MedicationRefillOrder.create!(
        treatment_plan: treatment_plan,
        requested_date: Date.today - rand(0..60).days,
        status: rand(0..2)
      )
    end
  end
end
