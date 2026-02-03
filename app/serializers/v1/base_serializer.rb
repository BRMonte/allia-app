module V1
  class BaseSerializer < ActiveModel::Serializer
    def created_at
      object.created_at&.strftime("%Y-%m-%d")
    end

    def updated_at
      object.updated_at&.strftime("%Y-%m-%d")
    end

    def format_date(date)
      date&.strftime("%Y-%m-%d")
    end
  end
end
