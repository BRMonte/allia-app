module V1
  class MedicationRefillOrderSerializer < ActiveModel::Serializer
    attributes :id,
               :treatment_plan_id,\
               :requested_date,
               :status,
               :created_at,
               :updated_at
  end
end
