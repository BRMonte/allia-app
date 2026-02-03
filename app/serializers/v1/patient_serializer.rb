module V1
  class PatientSerializer < ActiveModel::Serializer
    attributes :id,
               :first_name,
               :last_name,
               :date_of_birth,
               :email,
               :created_at,
               :updated_at
  end
end
