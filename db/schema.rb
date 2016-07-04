# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160704211615) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abstract_tools", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "line_item_logs", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.integer  "rental_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "tool_id",    null: false
    t.integer  "rental_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rentals", force: :cascade do |t|
    t.integer  "renter_id",                                   null: false
    t.integer  "owner_id",                                    null: false
    t.date     "checkout_date"
    t.date     "return_date"
    t.integer  "rental_price"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.time     "pickup_time"
    t.time     "pickup_end_time"
    t.integer  "status",                      default: 0,     null: false
    t.boolean  "owner_pick_up_confirmation",  default: false
    t.boolean  "renter_pick_up_confirmation", default: false
    t.boolean  "owner_return_confirmation",   default: false
    t.boolean  "renter_return_confirmation",  default: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "reviewer_id", null: false
    t.integer  "reviewee_id", null: false
    t.integer  "rating",      null: false
    t.text     "content",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tools", force: :cascade do |t|
    t.integer  "base_price",                        null: false
    t.boolean  "available",          default: true, null: false
    t.integer  "owner_id",                          null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "description"
    t.string   "model_number"
    t.integer  "abstract_tool_id",                  null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address",                             null: false
    t.string   "username",                            null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
