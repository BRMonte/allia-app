class MedicationRefillOrder < ApplicationRecord
  belongs_to :treatment_plan

  enum status: { pending: 0, approved: 1, rejected: 2, fulfilled: 3 }

  validates :requested_date, presence: true
  validates :status, presence: true
  validates :treatment_plan, presence: true
end
