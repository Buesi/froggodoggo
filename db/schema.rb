# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_15_122202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.text "company"
    t.text "website"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.boolean "hired"
    t.bigint "founder_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "paid"
    t.integer "hire_status", default: 0
    t.index ["company_id"], name: "index_contacts_on_company_id"
    t.index ["founder_id"], name: "index_contacts_on_founder_id"
  end

  create_table "founders", force: :cascade do |t|
    t.text "company"
    t.text "website"
    t.text "github"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "days_per_week"
    t.integer "duration"
    t.integer "specialisation"
    t.string "company_description"
    t.string "done_so_far"
    t.string "cool_work"
    t.string "impressive_build"
    t.string "important_in_5years"
    t.integer "years_in_software"
    t.string "qf_cat_dog"
    t.string "qf_thrones_breaking"
    t.string "qf_jungle"
    t.string "qf_belt_susp"
    t.boolean "profile_public"
    t.index ["user_id"], name: "index_founders_on_user_id"
  end

  create_table "profile_pictures", force: :cascade do |t|
    t.integer "color"
    t.string "name"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tech_breakdowns", force: :cascade do |t|
    t.text "name"
    t.integer "proficiency"
    t.integer "experience"
    t.bigint "founder_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["founder_id"], name: "index_tech_breakdowns_on_founder_id"
  end

  create_table "unreviewed_founder_entries", force: :cascade do |t|
    t.integer "review_status", default: 0
    t.bigint "founder_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "company_description"
    t.string "done_so_far"
    t.string "cool_work"
    t.string "impressive_build"
    t.string "important_in_5years"
    t.index ["founder_id"], name: "index_unreviewed_founder_entries_on_founder_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "surname"
    t.string "auth0_id"
    t.bigint "profile_picture_id"
    t.index ["profile_picture_id"], name: "index_users_on_profile_picture_id"
  end

  add_foreign_key "companies", "users"
  add_foreign_key "contacts", "companies"
  add_foreign_key "contacts", "founders"
  add_foreign_key "founders", "users"
  add_foreign_key "tech_breakdowns", "founders"
  add_foreign_key "unreviewed_founder_entries", "founders"
  add_foreign_key "users", "profile_pictures"
end
