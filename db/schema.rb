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

ActiveRecord::Schema.define(version: 20170110203754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.string   "title",      null: false
    t.float    "price",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image"
  end

  create_table "menus", force: :cascade do |t|
    t.string   "weekday"
    t.integer  "f_course_id_1"
    t.integer  "f_course_id_2"
    t.integer  "f_course_id_3"
    t.integer  "f_course_id_4"
    t.integer  "m_course_id_1"
    t.integer  "m_course_id_2"
    t.integer  "m_course_id_3"
    t.integer  "m_course_id_4"
    t.integer  "drink_id_1"
    t.integer  "drink_id_2"
    t.integer  "drink_id_3"
    t.integer  "drink_id_4"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "day"
    t.integer  "first_course_id", default: 0
    t.integer  "main_course_id",  default: 0
    t.integer  "drink_id",        default: 0
    t.float    "total",           default: 0.0, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

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

end
