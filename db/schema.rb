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

ActiveRecord::Schema[7.0].define(version: 2024_07_02_013100) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "apartments", force: :cascade do |t|
    t.integer "price"
    t.string "floor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "block_id", null: false
    t.string "name"
    t.boolean "isOccupied", default: false
    t.index ["block_id"], name: "index_apartments_on_block_id"
    t.index ["name"], name: "index_apartments_on_name"
  end

  create_table "block_admins", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "block_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["block_id"], name: "index_block_admins_on_block_id"
    t.index ["user_id", "block_id"], name: "index_block_admins_on_user_id_and_block_id", unique: true
    t.index ["user_id"], name: "index_block_admins_on_user_id"
  end

  create_table "block_keys", force: :cascade do |t|
    t.bigint "block_id", null: false
    t.string "key", default: -> { "gen_random_uuid()" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "viewkey", default: -> { "gen_random_uuid()" }, null: false
    t.index ["block_id"], name: "index_block_keys_on_block_id"
    t.index ["key"], name: "index_block_keys_on_key", unique: true
    t.index ["viewkey"], name: "index_block_keys_on_viewkey", unique: true
  end

  create_table "block_viewers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "block_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["block_id"], name: "index_block_viewers_on_block_id"
    t.index ["user_id", "block_id"], name: "index_block_viewers_on_user_id_and_block_id", unique: true
    t.index ["user_id"], name: "index_block_viewers_on_user_id"
  end

  create_table "blocks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "rent_session_id", null: false
    t.datetime "date"
    t.bigint "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rent_session_id"], name: "index_payments_on_rent_session_id"
  end

  create_table "rent_sessions", force: :cascade do |t|
    t.datetime "paymentDueDate"
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
    t.bigint "apartment_id", null: false
    t.datetime "startdate"
    t.index ["apartment_id"], name: "index_residents_on_apartment_id"
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
  add_foreign_key "block_keys", "blocks"
  add_foreign_key "block_viewers", "blocks"
  add_foreign_key "block_viewers", "users"
  add_foreign_key "payments", "rent_sessions"
  add_foreign_key "rent_sessions", "apartments"
  add_foreign_key "rent_sessions", "residents"
  add_foreign_key "residents", "apartments"
end
