class Patient < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :treatment_plans, dependent: :destroy
  has_many :medication_refill_orders, through: :treatment_plans
end
