require "rails_helper"

RSpec.describe "V1::Patients API", type: :request do
  describe "GET /v1/patients" do
    before { create_list(:patient, 3) }

    it "returns patients list" do
      get "/v1/patients"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "GET /v1/patients/:id" do
    let(:patient) { create(:patient) }

    it "returns a patient" do
      get "/v1/patients/#{patient.id}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(patient.id)
    end

    it "returns not found" do
      get "/v1/patients/999999"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /v1/patients" do
    let(:valid_params) do
      {
        patient: {
          first_name: "Jane",
          last_name: "Doe",
          date_of_birth: "1988-05-10",
          email: "jane@example.com"
        }
      }
    end

    let(:invalid_params) do
      {
        patient: {
          first_name: "",
          email: ""
        }
      }
    end

    it "creates a patient" do
      expect {
        post "/v1/patients", params: valid_params
      }.to change(Patient, :count).by(1)

      expect(response).to have_http_status(:created)
    end

    it "returns errors when invalid" do
      post "/v1/patients", params: invalid_params

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to have_key("errors")
    end
  end
end
