module V1
  class PatientSerializer < BaseSerializer
    attributes :id,
               :first_name,
               :last_name,
               :date_of_birth,
               :email,
               :created_at

    def date_of_birth
      format_date(object.date_of_birth)
    end
  end
end
