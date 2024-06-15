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

ActiveRecord::Schema[7.0].define(version: 2024_06_15_174055) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apartments", force: :cascade do |t|
    t.integer "price"
    t.string "floor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "block_id", null: false
    t.string "name"
    t.index ["block_id"], name: "index_apartments_on_block_id"
    t.index ["name"], name: "index_apartments_on_name"
  end

  create_table "block_admins", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "block_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["block_id"], name: "index_block_admins_on_block_id"
    t.index ["user_id"], name: "index_block_admins_on_user_id"
  end

  create_table "blocks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rent_sessions", force: :cascade do |t|
    t.datetime "startdate"
    t.string "paymentDueDate"
    t.bigint "resident_id", null: false
    t.bigint "apartment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["apartment_id"], name: "index_rent_sessions_on_apartment_id"
    t.index ["resident_id"], name: "index_rent_sessions_on_resident_id"
  end

  create_table "residents", force: :cascade do |t|
    t.string "name"
    t.string "physicalId"
    t.string "phonenumber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_residents_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "apartments", "blocks"
  add_foreign_key "block_admins", "blocks"
  add_foreign_key "block_admins", "users"
  add_foreign_key "rent_sessions", "apartments"
  add_foreign_key "rent_sessions", "residents"
end
