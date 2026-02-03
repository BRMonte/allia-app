require "rails_helper"

RSpec.describe "V1::MedicationRefillOrders API", type: :request do
  let(:patient) { create(:patient) }
  let(:treatment_plan) { create(:treatment_plan, patient: patient) }

  describe "GET /v1/medication_refill_orders" do
    let!(:order_1) do
      create(
        :medication_refill_order,
        treatment_plan: treatment_plan,
        status: "pending",
        requested_date: Date.today
      )
    end

    let!(:order_2) do
      create(
        :medication_refill_order,
        treatment_plan: treatment_plan,
        status: "approved",
        requested_date: Date.yesterday
      )
    end

    let!(:other_order) do
      create(
        :medication_refill_order,
        status: "rejected",
        requested_date: Date.tomorrow
      )
    end

    it "returns all orders" do
      get "/v1/medication_refill_orders"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end

    it "filters by treatment_plan_id" do
      get "/v1/medication_refill_orders",
          params: { treatment_plan_id: treatment_plan.id }

      ids = JSON.parse(response.body).map { |o| o["id"] }

      expect(ids).to match_array([ order_1.id, order_2.id ])
    end

    it "filters by status" do
      get "/v1/medication_refill_orders",
          params: { status: "pending" }

      expect(JSON.parse(response.body).size).to eq(1)
    end

    it "filters by requested_date" do
      get "/v1/medication_refill_orders",
          params: { requested_date: Date.today }

      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe "GET /v1/medication_refill_orders/:id" do
    let(:order) { create(:medication_refill_order, treatment_plan: treatment_plan) }

    it "returns an order" do
      get "/v1/medication_refill_orders/#{order.id}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(order.id)
    end

    it "returns not found" do
      get "/v1/medication_refill_orders/999999"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /v1/medication_refill_orders" do
    let(:valid_params) do
      {
        medication_refill_order: {
          treatment_plan_id: treatment_plan.id,
          requested_date: Date.today,
          status: "pending"
        }
      }
    end

    let(:invalid_params) do
      {
        medication_refill_order: {
          treatment_plan_id: nil
        }
      }
    end

    it "creates a medication refill order" do
      expect {
        post "/v1/medication_refill_orders", params: valid_params
      }.to change(MedicationRefillOrder, :count).by(1)

      expect(response).to have_http_status(:created)
    end

    it "returns errors when invalid" do
      post "/v1/medication_refill_orders", params: invalid_params

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to have_key("errors")
    end
  end

  describe "PATCH /v1/medication_refill_orders/:id" do
    let(:order) do
      create(
        :medication_refill_order,
        treatment_plan: treatment_plan,
        status: "pending"
      )
    end

    it "updates order status" do
      patch "/v1/medication_refill_orders/#{order.id}",
            params: { status: "approved" }

      expect(response).to have_http_status(:ok)
      expect(order.reload.status).to eq("approved")
    end

    it "returns not found" do
      patch "/v1/medication_refill_orders/999999",
            params: { status: "approved" }

      expect(response).to have_http_status(:not_found)
    end
  end
end
