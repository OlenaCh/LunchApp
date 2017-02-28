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

ActiveRecord::Schema.define(version: 20170206205326) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",              default: "", null: false
    t.string   "encrypted_password", default: "", null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "item_type",    null: false
    t.string   "title",        null: false
    t.float    "price",        null: false
    t.string   "image"
    t.string   "description"
    t.float    "fat"
    t.float    "carbohydrate"
    t.float    "protein"
    t.float    "calorie"
    t.float    "net_weight"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "items_menus", id: false, force: :cascade do |t|
    t.integer "item_id"
    t.integer "menu_id"
  end

  add_index "items_menus", ["item_id"], name: "index_items_menus_on_item_id", using: :btree
  add_index "items_menus", ["menu_id"], name: "index_items_menus_on_menu_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.string   "weekday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "item_id"
    t.integer  "amount"
    t.float    "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_items", ["item_id"], name: "index_order_items_on_item_id", using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "email"
    t.float    "total"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
