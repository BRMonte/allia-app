module V1
  class MedicationRefillOrderSerializer < BaseSerializer
    attributes :id,
               :treatment_plan_id,
               :requested_date,
               :status,
               :created_at,
               :updated_at

    def requested_date
      format_date(object.requested_date)
    end
  end
end
