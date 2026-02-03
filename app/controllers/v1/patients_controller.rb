module V1
  class PatientsController < ApplicationController
    before_action :set_patient, only: [ :show ]

    def index
      @patients = Patient.order(created_at: :desc).page(params[:page]).per(20)
      render json: @patients, each_serializer: V1::PatientSerializer, status: :ok
    end

    def show
      render json: @patient, serializer: V1::PatientSerializer, status: :ok
    end

    def create
      @patient = Patient.new(patient_params)

      if @patient.save
        render json: @patient, serializer: V1::PatientSerializer, status: :created
      else
        render json: { errors: @patient.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def set_patient
      @patient = Patient.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Patient not found" }, status: :not_found
    end

    def patient_params
      params.require(:patient).permit(:first_name, :last_name, :date_of_birth, :email)
    end
  end
end
