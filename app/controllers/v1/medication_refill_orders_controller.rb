module V1
  class MedicationRefillOrdersController < ApplicationController
    before_action :set_medication_refill_order, only: [ :show, :update ]

    def index
      @orders = MedicationRefillOrder
        .order(created_at: :desc)
        .page(params[:page]).per(20)

      @orders = @orders.where(treatment_plan_id: params[:treatment_plan_id]) if params[:treatment_plan_id].present?
      @orders = @orders.where(status: params[:status]) if params[:status].present?
      @orders = @orders.where(requested_date: params[:requested_date]) if params[:requested_date].present?

      render json: @orders, each_serializer: V1::MedicationRefillOrderSerializer, status: :ok
    end

    def show
      render json: @medication_refill_order, serializer: V1::MedicationRefillOrderSerializer, status: :ok
    end

    def create
      @medication_refill_order = MedicationRefillOrder.new(medication_refill_order_params)

      if @medication_refill_order.save
        render json: @medication_refill_order, serializer: V1::MedicationRefillOrderSerializer, status: :created
      else
        render json: { errors: @medication_refill_order.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @medication_refill_order.update(status: params[:status])
        render json: @medication_refill_order, serializer: V1::MedicationRefillOrderSerializer, status: :ok
      else
        render json: { errors: @medication_refill_order.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def set_medication_refill_order
      @medication_refill_order = MedicationRefillOrder.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Medication refill order not found" }, status: :not_found
    end

    def medication_refill_order_params
      params.require(:medication_refill_order).permit(:treatment_plan_id, :requested_date, :status)
    end
  end
end
