class TreatmentPlan < ApplicationRecord
  belongs_to :patient
  has_many :medication_refill_orders, dependent: :destroy

  enum status: { active: 0, completed: 1, cancelled: 2 }

  validates :name, presence: true
  validates :start_date, presence: true
  validates :status, presence: true
  validates :patient, presence: true

  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if end_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after start date")
    end
  end
end
