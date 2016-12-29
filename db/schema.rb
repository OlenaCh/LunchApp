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

ActiveRecord::Schema.define(version: 20161229203104) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.integer  "type_id"
    t.string   "title",      null: false
    t.float    "price",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image"
  end

  add_index "items", ["type_id"], name: "index_items_on_type_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "first_course_id", default: 0
    t.integer  "main_course_id",  default: 0
    t.integer  "drink_id",        default: 0
    t.float    "total",           default: 0.0, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "title",      null: false
    t.string   "address",    null: false
    t.string   "phone",      null: false
    t.string   "email",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "name",                                   null: false
    t.boolean  "admin",                  default: false, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["organization_id"], name: "index_users_on_organization_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "weekdays", force: :cascade do |t|
    t.integer  "daily_order_id"
    t.string   "daily_order_type"
    t.integer  "daily_menu_id"
    t.string   "daily_menu_type"
    t.string   "day"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "weekdays", ["daily_menu_type", "daily_menu_id"], name: "index_weekdays_on_daily_menu_type_and_daily_menu_id", using: :btree
  add_index "weekdays", ["daily_order_type", "daily_order_id"], name: "index_weekdays_on_daily_order_type_and_daily_order_id", using: :btree

end
