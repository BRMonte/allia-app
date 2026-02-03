# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2026_02_03_144453) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "medication_refill_orders", force: :cascade do |t|
    t.bigint "treatment_plan_id", null: false
    t.date "requested_date", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["requested_date"], name: "index_medication_refill_orders_on_requested_date"
    t.index ["status"], name: "index_medication_refill_orders_on_status"
    t.index ["treatment_plan_id"], name: "index_medication_refill_orders_on_treatment_plan_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.date "date_of_birth", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_patients_on_email", unique: true
    t.index ["last_name", "first_name"], name: "index_patients_on_last_name_and_first_name"
  end

  create_table "treatment_plans", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.string "name", null: false
    t.integer "status", default: 0, null: false
    t.date "start_date", null: false
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_treatment_plans_on_patient_id"
    t.index ["status"], name: "index_treatment_plans_on_status"
  end

  add_foreign_key "medication_refill_orders", "treatment_plans"
  add_foreign_key "treatment_plans", "patients"
end
