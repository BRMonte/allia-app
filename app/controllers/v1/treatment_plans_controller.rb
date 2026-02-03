module V1
  class TreatmentPlansController < ApplicationController
    before_action :set_treatment_plan, only: [ :update ]

    def index
      @treatment_plans = TreatmentPlan.where(patient_id: params[:patient_id])
                                      .order(created_at: :desc)
                                      .page(params[:page]).per(20)
      render json: @treatment_plans, each_serializer: V1::TreatmentPlanSerializer, status: :ok
    end

    def create
      @treatment_plan = TreatmentPlan.create!(treatment_plan_params)
      render json: @treatment_plan, serializer: V1::TreatmentPlanSerializer, status: :created
    end

    def update
      @treatment_plan.update!(status: params[:status])
      render json: @treatment_plan, serializer: V1::TreatmentPlanSerializer, status: :ok
    end

    private

    def set_treatment_plan
      @treatment_plan = TreatmentPlan.find(params[:id])
    end

    def treatment_plan_params
      params.require(:treatment_plan).permit(:patient_id, :name, :status, :start_date, :end_date)
    end
  end
end
