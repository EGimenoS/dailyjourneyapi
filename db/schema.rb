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

ActiveRecord::Schema.define(version: 2020_12_12_165802) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_messages", force: :cascade do |t|
    t.bigint "travel_id", null: false
    t.bigint "user_id", null: false
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["travel_id"], name: "index_chat_messages_on_travel_id"
    t.index ["user_id"], name: "index_chat_messages_on_user_id"
  end

  create_table "destinations", force: :cascade do |t|
    t.float "longitude"
    t.float "latitude"
    t.string "address"
    t.bigint "travel_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["travel_id"], name: "index_destinations_on_travel_id"
  end

  create_table "origins", force: :cascade do |t|
    t.float "longitude"
    t.float "latitude"
    t.string "address"
    t.bigint "travel_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["travel_id"], name: "index_origins_on_travel_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "travel_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.index ["travel_id"], name: "index_participants_on_travel_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "travels", force: :cascade do |t|
    t.bigint "owner_id"
    t.datetime "departure_time"
    t.integer "capacity"
    t.text "owner_comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "periodicity"
    t.index ["owner_id"], name: "index_travels_on_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "chat_messages", "travels"
  add_foreign_key "chat_messages", "users"
  add_foreign_key "destinations", "travels"
  add_foreign_key "origins", "travels"
  add_foreign_key "participants", "travels"
  add_foreign_key "participants", "users"
  add_foreign_key "travels", "users", column: "owner_id"
end
