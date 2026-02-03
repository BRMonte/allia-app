require "rails_helper"

RSpec.describe "V1::TreatmentPlans API", type: :request do
  let(:patient) { create(:patient) }

  describe "GET /v1/treatment_plans" do
    before do
      create_list(:treatment_plan, 3, patient: patient)
      create(:treatment_plan)
    end

    it "returns treatment plans for a patient" do
      get "/v1/treatment_plans", params: { patient_id: patient.id }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "POST /v1/treatment_plans" do
    let(:valid_params) do
      {
        treatment_plan: {
          patient_id: patient.id,
          name: "Physiotherapy",
          status: "active",
          start_date: Date.today
        }
      }
    end

    let(:invalid_params) do
      {
        treatment_plan: {
          patient_id: nil,
          name: ""
        }
      }
    end

    it "creates a treatment plan" do
      expect {
        post "/v1/treatment_plans", params: valid_params
      }.to change(TreatmentPlan, :count).by(1)

      expect(response).to have_http_status(:created)
    end

    it "returns errors when invalid" do
      post "/v1/treatment_plans", params: invalid_params

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to have_key("errors")
    end
  end

  describe "PATCH /v1/treatment_plans/:id" do
    let(:treatment_plan) { create(:treatment_plan, patient: patient, status: "active") }

    it "updates treatment plan status" do
      patch "/v1/treatment_plans/#{treatment_plan.id}",
            params: { status: "completed" }

      expect(response).to have_http_status(:ok)
      expect(treatment_plan.reload.status).to eq("completed")
    end

    it "returns not found" do
      patch "/v1/treatment_plans/999999",
            params: { status: "completed" }

      expect(response).to have_http_status(:not_found)
    end
  end
end
