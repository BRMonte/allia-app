class CreateMedicationRefillOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :medication_refill_orders do |t|
      t.references :treatment_plan, null: false, foreign_key: true
      t.date :requested_date, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    add_index :medication_refill_orders, :status
    add_index :medication_refill_orders, :requested_date
  end
end
