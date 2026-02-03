module V1
  class TreatmentPlanSerializer < ActiveModel::Serializer
    attributes :id,
               :patient_id,
               :name,
               :status,
               :start_date,
               :end_date,
               :created_at,
               :updated_at
  end
end
