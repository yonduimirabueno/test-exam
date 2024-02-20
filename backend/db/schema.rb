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

ActiveRecord::Schema[7.0].define(version: 2024_02_20_052507) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accessway_distances", force: :cascade do |t|
    t.bigint "accessway_id"
    t.bigint "parking_slot_id"
    t.decimal "distance", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accessway_id"], name: "index_accessway_distances_on_accessway_id"
    t.index ["parking_slot_id"], name: "index_accessway_distances_on_parking_slot_id"
  end

  create_table "accessways", force: :cascade do |t|
    t.bigint "parking_lot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parking_lot_id"], name: "index_accessways_on_parking_lot_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "parking_slot_id"
    t.bigint "vehicle_id"
    t.bigint "ticket_id"
    t.string "plate_no", null: false
    t.decimal "flat_rate", default: "0.0", null: false
    t.decimal "exceeding_hourly_rate", default: "0.0", null: false
    t.decimal "whole_day_flat_rate", default: "0.0", null: false
    t.decimal "amount", default: "0.0", null: false
    t.datetime "time_in"
    t.datetime "time_out"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parking_slot_id"], name: "index_invoices_on_parking_slot_id"
    t.index ["ticket_id"], name: "index_invoices_on_ticket_id"
    t.index ["vehicle_id"], name: "index_invoices_on_vehicle_id"
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri"
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "parking_lots", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "flat_rate", default: "40.0", null: false
    t.decimal "whole_day_flat_rate", default: "5000.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parking_slots", force: :cascade do |t|
    t.bigint "parking_lot_id"
    t.datetime "time_in"
    t.datetime "time_out"
    t.string "type"
    t.decimal "rate", default: "0.0", null: false
    t.boolean "is_out_of_service", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parking_lot_id"], name: "index_parking_slots_on_parking_lot_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "parking_slot_id"
    t.bigint "vehicle_id"
    t.string "plate_no", null: false
    t.boolean "is_returning_vehicle", default: false
    t.decimal "flat_rate", default: "0.0", null: false
    t.decimal "exceeding_hourly_rate", default: "0.0", null: false
    t.decimal "whole_day_flat_rate", default: "0.0", null: false
    t.datetime "time_in"
    t.datetime "time_out"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parking_slot_id"], name: "index_tickets_on_parking_slot_id"
    t.index ["vehicle_id"], name: "index_tickets_on_vehicle_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "type"
    t.string "plate_no", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
end
