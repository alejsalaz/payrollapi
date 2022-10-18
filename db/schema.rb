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

ActiveRecord::Schema[7.0].define(version: 2022_10_18_013555) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "contract_type", ["work or labor", "fixed-term", "indefinite", "apprenticeship", "temporary"]
  create_enum "employee_risk_class", ["i", "ii", "iii", "iv", "v"]
  create_enum "period_state", ["paid", "draft", "failed"]
  create_enum "user_role", ["admin", "accountant", "user"]

  create_table "companies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "nit", null: false
    t.string "legal_name", null: false
    t.string "display_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "card_id", null: false
    t.uuid "company_id", null: false
    t.string "full_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "risk_class", null: false, enum_type: "employee_risk_class"
    t.string "job_title", null: false
    t.decimal "base_salary", null: false
    t.date "start_date", null: false
    t.date "termination_date", null: false
    t.enum "contract_type", null: false, enum_type: "contract_type"
    t.index ["company_id"], name: "index_employees_on_company_id"
  end

  create_table "payrolls", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "employee_id", null: false
    t.uuid "period_id", null: false
    t.decimal "salary_income", precision: 17, scale: 2, default: "0.0", null: false
    t.decimal "non_salary_income", precision: 17, scale: 2, default: "0.0", null: false
    t.decimal "deduction", precision: 17, scale: 2, default: "0.0", null: false
    t.decimal "transportation", precision: 17, scale: 2, default: "0.0", null: false
    t.decimal "employee_healthcare", precision: 17, scale: 2, default: "0.0", null: false
    t.decimal "employee_pension", precision: 17, scale: 2, default: "0.0", null: false
    t.decimal "solidarity_fund", precision: 17, scale: 2, default: "0.0", null: false
    t.decimal "subsistence_account", precision: 17, scale: 2, default: "0.0", null: false
    t.decimal "compensation_fund", precision: 17, scale: 2, default: "0.0", null: false
    t.decimal "icbf", precision: 17, scale: 2, default: "0.0", null: false
    t.decimal "sena", precision: 17, scale: 2, default: "0.0", null: false
    t.decimal "severance", precision: 17, scale: 2, default: "0.0", null: false
    t.decimal "interest", precision: 17, scale: 2, default: "0.0", null: false
    t.decimal "premium", precision: 17, scale: 2, default: "0.0", null: false
    t.decimal "vacation", precision: 17, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "employer_healthcare", precision: 17, scale: 2, default: "0.0", null: false
    t.decimal "employer_pension", precision: 17, scale: 2, default: "0.0", null: false
    t.index ["employee_id"], name: "index_payrolls_on_employee_id"
    t.index ["period_id"], name: "index_payrolls_on_period_id"
  end

  create_table "periods", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.date "start_date", default: "2022-10-01", null: false
    t.date "end_date", default: "2022-10-31", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "state", default: "draft", null: false, enum_type: "period_state"
    t.uuid "company_id", null: false
    t.index ["company_id"], name: "index_periods_on_company_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "full_name", null: false
    t.citext "email", null: false
    t.string "password_digest", null: false
    t.uuid "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "role", default: "user", null: false, enum_type: "user_role"
    t.index ["company_id"], name: "index_users_on_company_id"
  end

  add_foreign_key "employees", "companies"
  add_foreign_key "payrolls", "employees"
  add_foreign_key "payrolls", "periods"
  add_foreign_key "periods", "companies"
  add_foreign_key "users", "companies"
end
