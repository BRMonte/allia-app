class CreateTreatmentPlans < ActiveRecord::Migration[7.2]
  def change
    create_table :treatment_plans do |t|
      t.references :patient, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :status, null: false, default: 0
      t.date :start_date, null: false
      t.date :end_date

      t.timestamps
    end

    add_index :treatment_plans, :patient_id
    add_index :treatment_plans, :status
  end
end
