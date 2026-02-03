module V1
  class TreatmentPlanSerializer < BaseSerializer
    attributes :id,
               :patient_id,
               :name,
               :status,
               :start_date,
               :end_date,
               :created_at,
               :updated_at

    def start_date
      object.start_date&.strftime("%Y-%m-%d")
    end

    def end_date
      object.end_date&.strftime("%Y-%m-%d")
    end
  end
end
